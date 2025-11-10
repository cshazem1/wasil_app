// core/pagination/widgets/pagination_list_view.dart
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
  late ScrollController _scrollController;
  late PaginationCubit<T> _cubit;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.controller ?? ScrollController();
    _cubit = widget.cubit;
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (currentScroll >= maxScroll - widget.loadMoreThreshold &&
        _cubit.hasMore &&
        _cubit.state is !LoadingMore) {
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

          loading: () => widget.loadingWidget ??
              const Center(child: CircularProgressIndicator()),

          loaded: (items, hasMore) {
            if (items.isEmpty) {
              return widget.emptyWidget ??
                  const Center(child: Text('No items found'));
            }

            return RefreshIndicator(
              onRefresh: () => _cubit.refresh(),
              child: ListView.builder(
                controller: _scrollController,
                padding: widget.padding,
                shrinkWrap: widget.shrinkWrap,
                physics: widget.physics,
                itemCount: items.length + (hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index >= items.length) {
                    return widget.loadMoreWidget ??
                        Padding(
                          padding: EdgeInsets.all(16.w),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                  }
                  return widget.itemBuilder(context, items[index], index);
                },
              ),
            );
          },

          loadingMore: (items, hasMore) {
            return ListView.builder(
              controller: _scrollController,
              padding: widget.padding,
              shrinkWrap: widget.shrinkWrap,
              physics: widget.physics,
              itemCount: items.length + 1,
              itemBuilder: (context, index) {
                if (index >= items.length) {
                  return widget.loadMoreWidget ??
                      Padding(
                        padding: EdgeInsets.all(16.w),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                }
                return widget.itemBuilder(context, items[index], index);
              },
            );
          },

          error: (message) {
            final items = _cubit.items;

            if (items.isEmpty) {
              return widget.errorBuilder?.call(context, message) ??
                  Center(
                    child: RefreshIndicator(
                      onRefresh: () => _cubit.loadInitial(),
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
                                  onPressed: () => _cubit.loadInitial(),
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

            return ListView.builder(
              controller: _scrollController,
              padding: widget.padding,
              itemCount: items.length + 1,
              itemBuilder: (context, index) {
                if (index >= items.length) {
                  return Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            message,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => _cubit.loadMore(),
                          icon: const Icon(Icons.refresh),
                        ),
                      ],
                    ),
                  );
                }
                return widget.itemBuilder(context, items[index], index);
              },
            );
          },
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
