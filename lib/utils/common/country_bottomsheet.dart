import 'package:flutter/material.dart';

import '../app_spacing.dart';
import '../app_strings.dart';
import 'app_colors.dart';
import 'app_text.dart';
import 'countries.dart';
import 'textform_field.dart';
import '../utils.dart';

Future<Country?> showCountryPicker(
  BuildContext context, {
  Country? selectedCountry,
}) {
  return showModalBottomSheet<Country>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) => CountryBottomSheet(selectedCountry: selectedCountry),
  );
}

class CountryBottomSheet extends StatefulWidget {
  const CountryBottomSheet({super.key, this.selectedCountry});

  final Country? selectedCountry;

  @override
  State<CountryBottomSheet> createState() => _CountryBottomSheetState();
}

class _CountryBottomSheetState extends State<CountryBottomSheet> {
  final _searchController = TextEditingController();
  List<Country> _countries = allCountries;

  void _search(String value) {
    final query = value.trim().toLowerCase();
    setState(() {
      _countries = query.isEmpty
          ? allCountries
          : allCountries
                .where(
                  (country) =>
                      country.name!.toLowerCase().contains(query) ||
                      country.dialCode!.contains(query),
                )
                .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => Utils.hideKeyboard(context),
      child: SafeArea(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.72,
          child: Column(
            children: [
              Container(
                width: 42,
                height: 4,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(
                  AppSpacing.screenHorizontal,
                  20,
                  AppSpacing.screenHorizontal,
                  4,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AppText(
                    text: AppStrings.selectCountry,
                    textSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenHorizontal,
                ),
                child: CommonTextField(
                  controller: _searchController,
                  hintText: AppStrings.searchCountry,
                  textColor: AppColors.black,
                  hintTextColor: AppColors.hintText,
                  fillColor: AppColors.white,
                  borderColor: AppColors.border,
                  prefixIcon: const Icon(Icons.search, size: 20),
                  onChanged: _search,
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenHorizontal,
                    6,
                    AppSpacing.screenHorizontal,
                    20,
                  ),
                  itemCount: _countries.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final country = _countries[index];
                    final selected =
                        country.code == widget.selectedCountry?.code;
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () => Navigator.pop(context, country),
                      leading: AppText(text: country.flag!, textSize: 24),
                      title: AppText(
                        text: country.name!,
                        textSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppText(
                            text: '+${country.dialCode}',
                            color: AppColors.textSecondary,
                            textSize: 13,
                          ),
                          if (selected) ...[
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.check_circle,
                              color: AppColors.primary,
                              size: 18,
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
