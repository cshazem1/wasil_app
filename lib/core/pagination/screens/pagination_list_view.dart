import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubit/pagination_cubit.dart';

class PaginationListView<T> extends StatefulWidget {
  final PaginationCubit<T> cubit;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final Widget? emptyWidget;
  final Widget? loadMoreWidget;
  final double loadMoreThreshold;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final ScrollController? controller;
  final Widget Function(BuildContext, String)? errorBuilder;

  const PaginationListView({
    super.key,
    required this.cubit,
    required this.itemBuilder,
    this.loadingWidget,
    this.errorWidget,
    this.emptyWidget,
    this.loadMoreWidget,
    this.loadMoreThreshold = 200.0,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
    this.controller,
    this.errorBuilder,
  });

  @override
  State<PaginationListView<T>> createState() => _PaginationListViewState<T>();
}

class _PaginationListViewState<T> extends State<PaginationListView<T>> {
  late final ScrollController _scrollController =
      widget.controller ?? ScrollController();
  late final PaginationCubit<T> _cubit = widget.cubit;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (currentScroll >= maxScroll - widget.loadMoreThreshold &&
        _cubit.hasMore &&
        _cubit.state is! LoadingMore) {
      _cubit.loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaginationCubit<T>, PaginationState<T>>(
      bloc: _cubit,
      builder: (context, state) {
        return state.when(
          initial: () => widget.emptyWidget ?? const SizedBox.shrink(),

          loading: () => widget.loadingWidget ?? const _CenterLoader(),

          loaded: (items, hasMore) => _PaginatedList<T>(
            scrollController: _scrollController,
            items: items,
            hasMore: hasMore,
            itemBuilder: widget.itemBuilder,
            loadMoreWidget: widget.loadMoreWidget,
            padding: widget.padding,
            shrinkWrap: widget.shrinkWrap,
            physics: widget.physics,
            onRefresh: _cubit.refresh,
            showLoader: hasMore,
          ),

          loadingMore: (items, hasMore) => _PaginatedList<T>(
            scrollController: _scrollController,
            items: items,
            hasMore: true,
            itemBuilder: widget.itemBuilder,
            loadMoreWidget: widget.loadMoreWidget,
            padding: widget.padding,
            shrinkWrap: widget.shrinkWrap,
            physics: widget.physics,
            onRefresh: _cubit.refresh,
            showLoader: true,
          ),

          error: (message) => _ErrorView(
            context: context,
            message: message,
            items: _cubit.items,
            emptyWidget: widget.emptyWidget,
            errorBuilder: widget.errorBuilder,
            onRetry: _cubit.loadInitial,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }
}

class _PaginatedList<T> extends StatelessWidget {
  final ScrollController scrollController;
  final List<T> items;
  final bool hasMore;
  final Widget Function(BuildContext, T, int) itemBuilder;
  final Widget? loadMoreWidget;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final Future<void> Function() onRefresh;
  final bool showLoader;

  const _PaginatedList({
    required this.scrollController,
    required this.items,
    required this.hasMore,
    required this.itemBuilder,
    this.loadMoreWidget,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
    required this.onRefresh,
    required this.showLoader,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        controller: scrollController,
        padding: padding,
        shrinkWrap: shrinkWrap,
        physics: physics,
        itemCount: items.length + (showLoader ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < items.length) {
            return itemBuilder(context, items[index], index);
          }
          return loadMoreWidget ??
              Padding(
                padding: EdgeInsets.all(16.w),
                child: const Center(child: CircularProgressIndicator()),
              );
        },
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final BuildContext context;
  final String message;
  final List items;
  final Widget? emptyWidget;
  final Widget Function(BuildContext, String)? errorBuilder;
  final VoidCallback onRetry;

  const _ErrorView({
    required this.context,
    required this.message,
    required this.items,
    this.emptyWidget,
    this.errorBuilder,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return errorBuilder?.call(context, message) ??
          Center(
            child: RefreshIndicator(
              onRefresh: () async => onRetry(),
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 60,
                          color: Colors.red,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          message,
                          style: TextStyle(fontSize: 14.sp),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16.h),
                        ElevatedButton(
                          onPressed: onRetry,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
    }
    // عرض العناصر مع إعادة عرضهم حتى في حالة الخطأ
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => emptyWidget ?? const SizedBox.shrink(),
    );
  }
}

class _CenterLoader extends StatelessWidget {
  const _CenterLoader();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
