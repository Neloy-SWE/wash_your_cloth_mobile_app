/* 
Created by Neloy on 29 June, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utilities/app_color.dart';
import '../../utilities/app_size.dart';
import '../../utilities/app_text.dart';
import '../../utilities/app_validator.dart';
import 'custom_title.dart';

class CustomFieldPrimary extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final void Function()? onTap;

  final String? title;
  final bool isSecure;
  final bool isReadOnly;
  final bool isArea;

  // final String hint;
  final String label;
  final void Function(String)? onFieldSubmitted;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final bool isRequired;
  final List<TextInputFormatter>? inputFormatters;

  const CustomFieldPrimary({
    super.key,
    this.validator,
    required this.controller,
    required this.textInputType,
    required this.textInputAction,
    this.onChanged,
    // this.hint = "",
    this.label = "",
    this.onFieldSubmitted,
    this.prefixWidget,
    this.suffixWidget,
    this.title,
    this.isSecure = false,
    this.isRequired = true,
    this.inputFormatters,
    this.isReadOnly = false,
    this.onTap,
    this.isArea = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        title != null
            ? CustomTitlePrimary(title: title!, isRequired: isRequired)
            : AppSize.noGap,

        TextFormField(
          style: AppText.style.bodyMedium,
          validator: validator,
          controller: controller,
          keyboardType: textInputType,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          inputFormatters: inputFormatters,
          obscureText: isSecure,
          minLines: isArea ? 3 : null,
          maxLines: isArea ? 5 : 1,
          readOnly: isReadOnly,
          onTap: onTap,
          decoration: InputDecoration(
            errorStyle: AppText.style.bodySmall,
            prefixIcon: prefixWidget,
            suffixIcon: suffixWidget,
            contentPadding: AppSize.paddingAll10,
            alignLabelWithHint: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: OutlineInputBorder(
              borderSide: const BorderSide(width: 0.5, color: Colors.black),
              borderRadius: AppSize.borderRadiusAll8,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1,
                color: AppColor.colorPrimary,
              ),
              borderRadius: AppSize.borderRadiusAll8,
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1,
                color: AppColor.colorDanger,
              ),
              borderRadius: AppSize.borderRadiusAll8,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 0.5, color: Colors.black),
              borderRadius: AppSize.borderRadiusAll8,
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: Colors.black54),
              borderRadius: AppSize.borderRadiusAll8,
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1,
                color: AppColor.colorDanger,
              ),
              borderRadius: AppSize.borderRadiusAll8,
            ),

            // hintText: hint,
            labelText: label,

            // hintStyle: AppText.style.bodySmall!.copyWith(
            //   color: AppColor.colorTextHint,
            //   fontSize: 15,
            // ),
            labelStyle: AppText.style.bodyMedium!.copyWith(
              color: AppColor.colorHint,
            ),
          ),
        ),
      ],
    );
  }
}

class CustomFieldOTP extends StatelessWidget {
  final List<TextEditingController> otpController;
  final List<FocusNode> otpFocusNode;
  final bool isError;

  const CustomFieldOTP({
    super.key,
    required this.otpController,
    required this.otpFocusNode,
    required this.isError,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          otpController.length,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: SizedBox(
              height: 62,
              width: 55,
              child: TextField(
                controller: otpController[index],
                focusNode: otpFocusNode[index],
                textAlign: TextAlign.center,
                cursorColor: AppColor.colorPrimary,
                keyboardType: TextInputType.number,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: isError ? AppColor.colorDanger : AppColor.colorPrimary,
                ),
                cursorWidth: 0.5,
                cursorHeight: 25,
                onTap: () {
                  final text = otpController[index].text;
                  otpController[index].selection = TextSelection.fromPosition(
                    TextPosition(offset: text.length),
                  );
                },
                onChanged: (value) {
                  if (value.length == 1 && index < otpController.length - 1) {
                    FocusScope.of(
                      context,
                    ).requestFocus(otpFocusNode[index + 1]);
                    Future.delayed(Duration.zero, () {
                      final text = otpController[index + 1].text;
                      otpController[index + 1].selection =
                          TextSelection.fromPosition(
                            TextPosition(offset: text.length),
                          );
                    });
                  } else if (value.isEmpty && index > 0) {
                    FocusScope.of(
                      context,
                    ).requestFocus(otpFocusNode[index - 1]);

                    Future.delayed(Duration.zero, () {
                      final text = otpController[index - 1].text;
                      otpController[index - 1].selection =
                          TextSelection.fromPosition(
                            TextPosition(offset: text.length),
                          );
                    });
                  }
                },
                inputFormatters: [LengthLimitingTextInputFormatter(1)],
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  hintText: "0",
                  hintStyle: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(color: Colors.black12),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: isError
                          ? AppColor.colorDanger
                          : AppColor.colorPrimary,
                    ),
                    borderRadius: AppSize.borderRadiusAll8,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: isError
                          ? AppColor.colorDanger
                          : AppColor.colorPrimary,
                    ),
                    borderRadius: AppSize.borderRadiusAll8,
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: AppColor.colorDanger,
                    ),
                    borderRadius: AppSize.borderRadiusAll8,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: isError
                          ? AppColor.colorDanger
                          : AppColor.colorPrimary,
                    ),
                    borderRadius: AppSize.borderRadiusAll8,
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.black54,
                    ),
                    borderRadius: AppSize.borderRadiusAll8,
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: AppColor.colorDanger,
                    ),
                    borderRadius: AppSize.borderRadiusAll8,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomFieldDropdownSearch<T> extends StatefulWidget {
  final String? title;
  final bool isRequired;
  final String label;
  final TextEditingController controller;
  final List<T> items;
  final String Function(T item) itemAsString;
  final ValueChanged<T?> onSelected;
  final double maxMenuHeight;
  final String? Function(String?)? validator;

  const CustomFieldDropdownSearch({
    super.key,
    this.title,
    this.isRequired = false,
    this.label = "",
    required this.controller,
    required this.items,
    required this.itemAsString,
    required this.onSelected,
    this.maxMenuHeight = 350.0,
    this.validator,
  });

  @override
  State<CustomFieldDropdownSearch<T>> createState() =>
      _CustomFieldDropdownSearchState<T>();
}

class _CustomFieldDropdownSearchState<T>
    extends State<CustomFieldDropdownSearch<T>> {
  final LayerLink _layerLink = LayerLink();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _fieldContainerKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  List<T> _filteredItems = [];
  bool _isOpen = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _filteredItems = List<T>.from(widget.items);
    _focusNode.addListener(_handleFocusChange);
    _errorText = _getValidationError(widget.controller.text);
  }

  @override
  void didUpdateWidget(covariant CustomFieldDropdownSearch<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      _filteredItems = List<T>.from(widget.items);
      _validateValue();
      if (_isOpen) {
        _overlayEntry?.markNeedsBuild();
      }
    }
    if (oldWidget.validator != widget.validator) {
      _validateValue();
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _closeOverlay();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus) {
      _openOverlay();
    } else {
      _closeOverlay();
    }
  }

  String? _getValidationError(String? value) {
    if (value != null && value.isNotEmpty) {
      final exists = widget.items.any(
        (item) => widget.itemAsString(item) == value,
      );
      if (!exists) {
        return AppValidator.validatorInvalidDropdownSelect;
      }
    }
    if (widget.validator != null) {
      return widget.validator!(value);
    }
    return null;
  }

  void _validateValue() {
    final newError = _getValidationError(widget.controller.text);
    if (_errorText == newError) {
      return;
    }
    setState(() {
      _errorText = newError;
    });
    if (_isOpen) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _isOpen) {
          _overlayEntry?.markNeedsBuild();
        }
      });
    }
  }

  void _filterItems(String query) {
    final normalizedQuery = query.trim().toLowerCase();
    if (normalizedQuery.isEmpty) {
      _filteredItems = List<T>.from(widget.items);
    } else {
      _filteredItems = widget.items
          .where(
            (item) => widget
                .itemAsString(item)
                .toLowerCase()
                .contains(normalizedQuery),
          )
          .toList();
    }
    _validateValue();
    if (_isOpen) {
      _overlayEntry?.markNeedsBuild();
    }
    setState(() {});
  }

  void _openOverlay() {
    if (_isOpen) {
      return;
    }
    _filteredItems = List<T>.from(widget.items);
    _overlayEntry = OverlayEntry(
      builder: (context) {
        final renderBox =
            _fieldContainerKey.currentContext?.findRenderObject() as RenderBox?;
        final size = renderBox?.size ?? Size.zero;
        return Positioned(
          width: size.width,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0.0, size.height + 4.0),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              child: Container(
                constraints: BoxConstraints(maxHeight: widget.maxMenuHeight),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AppSize.borderRadiusAll8,
                  border: Border.all(color: Colors.black, width: 0.5),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: _filteredItems.isEmpty
                      ? Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            AppText.noOptionFound,
                            style: AppText.style.bodyLarge!.copyWith(
                              color: Colors.black26,
                            ),
                          ),
                        )
                      : Scrollbar(
                          controller: _scrollController,
                          thumbVisibility: true,
                          child: ListView.separated(
                            controller: _scrollController,
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 10.0,
                            ),
                            shrinkWrap: true,
                            itemCount: _filteredItems.length,
                            itemBuilder: (context, index) {
                              final item = _filteredItems[index];
                              final text = widget.itemAsString(item);
                              return InkWell(
                                onTap: () {
                                  widget.controller.text = text;
                                  widget.onSelected(item);
                                  _filteredItems = List<T>.from(widget.items);
                                  _validateValue();
                                  _focusNode.unfocus();
                                },
                                child: Text(
                                  text,
                                  style: AppText.style.bodyMedium,
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                                  return Divider();
                                },
                          ),
                        ),
                ),
              ),
            ),
          ),
        );
      },
    );
    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isOpen = true;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _isOpen) {
        _overlayEntry?.markNeedsBuild();
      }
    });
  }

  void _closeOverlay() {
    if (!_isOpen) {
      return;
    }
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) {
      setState(() {
        _isOpen = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.title != null) ...[
          CustomTitlePrimary(
            title: widget.title!,
            isRequired: widget.isRequired,
          ),
        ],
        CompositedTransformTarget(
          link: _layerLink,
          child: Column(
            key: _fieldContainerKey,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                focusNode: _focusNode,
                controller: widget.controller,
                style: AppText.style.bodyMedium,
                validator: _getValidationError,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  errorStyle: const TextStyle(fontSize: 0, height: 0),
                  contentPadding: AppSize.paddingAll10,
                  alignLabelWithHint: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: widget.label,
                  labelStyle: AppText.style.bodyMedium!.copyWith(
                    color: AppColor.colorHint,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isOpen
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: AppColor.colorPrimary,
                    ),
                    onPressed: () {
                      if (_isOpen) {
                        _focusNode.unfocus();
                      } else {
                        _focusNode.requestFocus();
                      }
                    },
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 0.5,
                      color: Colors.black,
                    ),
                    borderRadius: AppSize.borderRadiusAll8,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: AppColor.colorPrimary,
                    ),
                    borderRadius: AppSize.borderRadiusAll8,
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: AppColor.colorDanger,
                    ),
                    borderRadius: AppSize.borderRadiusAll8,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 0.5,
                      color: Colors.black,
                    ),
                    borderRadius: AppSize.borderRadiusAll8,
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.black54,
                    ),
                    borderRadius: AppSize.borderRadiusAll8,
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: AppColor.colorDanger,
                    ),
                    borderRadius: AppSize.borderRadiusAll8,
                  ),
                ),
                onChanged: (value) {
                  _filterItems(value);
                  if (!_isOpen) {
                    _openOverlay();
                  }
                },
              ),
              if (_errorText != null && _errorText!.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.only(
                    left: 12.0,
                    top: 0.0,
                    right: 12.0,
                  ),
                  child: Text(_errorText!, style: AppText.style.bodySmall),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
