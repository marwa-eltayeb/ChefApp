import 'dart:async';
import 'package:chef_app/app/router/routes.dart';
import 'package:chef_app/core/constants/app_strings.dart';
import 'package:chef_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:chef_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:chef_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:chef_app/features/profile/presentation/cubit/profile_state.dart';
import 'package:chef_app/features/profile/presentation/widgets/custom_menu_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  late final ProfileCubit _profileCubit;
  late final AuthCubit _authCubit;
  late final StreamSubscription _authSub;

  @override
  void initState() {
    super.initState();

    _profileCubit = GetIt.I<ProfileCubit>()..loadProfile();

    _authCubit = GetIt.I<AuthCubit>();
    _authSub = _authCubit.stream.listen((state) {
      if (state is AuthLoggedOut && mounted) {
        context.go(Routes.login);
      }
    });
  }

  @override
  void dispose() {
    _authSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _profileCubit,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F8F8),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
              child: BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProfileLoaded) {
                    final profile = state.profile;

                    return Column(
                      children: [
                        const SizedBox(height: 40),
                        // Profile Image with edit icon
                        Stack(
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 4),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 2,
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 58,
                                backgroundImage: profile.profilePic != null &&
                                    profile.profilePic!.isNotEmpty
                                    ? NetworkImage(profile.profilePic!)
                                    : null,
                                backgroundColor: Colors.grey,
                                child: (profile.profilePic == null ||
                                    profile.profilePic!.isEmpty)
                                    ? const Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Colors.white,
                                )
                                    : null,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Name
                        Text(
                          profile.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2D2D2D),
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Email
                        Text(
                          profile.email,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF666666),
                          ),
                        ),

                        const SizedBox(height: 48),

                        // Menu Items
                        CustomMenuItem(
                          icon: Icons.person_outline,
                          text: AppStrings.editProfile.tr(),
                          onTap: () {
                            context.push(
                              Routes.editProfile,
                              extra: {'cubit': _profileCubit, 'profile': profile},
                            );
                          },
                        ),

                        const SizedBox(height: 16),

                        CustomMenuItem(
                          icon: Icons.lock_outline,
                          text: AppStrings.password.tr() ,
                          onTap: () {
                            context.push(Routes.changePassword);
                          },
                        ),

                        const SizedBox(height: 16),

                        CustomMenuItem(
                          icon: Icons.settings_outlined,
                          text: AppStrings.settings.tr(),
                          onTap: () {
                            context.push(Routes.settings);
                          },
                        ),

                        const SizedBox(height: 16),

                        CustomMenuItem(
                          icon: Icons.logout_outlined,
                          text: AppStrings.logout.tr(),
                          textColor: const Color(0xFFFF8C00),
                          onTap: () {
                            _authCubit.logout();
                          },
                        ),
                      ],
                    );
                  } else if (state is ProfileError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox.shrink();
                },
              ),
          ),
        ),
      ),
    );
  }
}
