// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// // Removed FlutterFlow-specific imports
// // Import your own auth and backend utilities if needed

// // Assuming you have an EditProfileModel or similar, otherwise you can remove it
// import 'edit_profile_model.dart';

class EditProfileWidget extends StatefulWidget {
  const EditProfileWidget({super.key});

  @override
  State<EditProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  // Removed FlutterFlow model
  late TextEditingController fullNameController;
  late FocusNode fullNameFocusNode;

  late TextEditingController emailController;
  late FocusNode emailFocusNode;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool unsavedChanges = false;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with current user data
    fullNameController = TextEditingController(text: currentUserDisplayName);
    fullNameFocusNode = FocusNode();

    emailController = TextEditingController(text: currentUserEmail);
    emailFocusNode = FocusNode();

    // Log screen view event if needed
    // logFirebaseEvent('screen_view', parameters: {'screen_name': 'EditProfile'});
  }

  @override
  void dispose() {
    fullNameController.dispose();
    fullNameFocusNode.dispose();
    emailController.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }

  get currentUserDisplayName => null;
  
  get currentUserEmail => null;
  
  get currentUserReference => null;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: colorScheme.surface,
        appBar: AppBar(
          backgroundColor: colorScheme.secondary,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: colorScheme.onSecondary),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            'Edit Profile',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSecondary,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                // Save action logic
                // Example:
                await currentUserReference!.update({
                  'displayName': fullNameController.text,
                });
                setState(() {
                  unsavedChanges = false;
                });
              },
              child: Text(
                'Save',
                style: TextStyle(
                  color: colorScheme.onSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                const Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                // Full Name Field
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Full Name',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    TextFormField(
                      controller: fullNameController,
                      focusNode: fullNameFocusNode,
                      onChanged: (_) {}, // change it in future TODO:
                      autofocus: false,
                      autofillHints: const [AutofillHints.name],
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: colorScheme.surface,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: colorScheme.primary,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: colorScheme.error,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: colorScheme.error,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: colorScheme.surface,
                      ),
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      minLines: 1,
                      cursorColor: colorScheme.primary,
                      validator: (value) {
                        // Add your validation logic if needed
                        return null;
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Reset Password Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Reset Password',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Receive a link via email to reset your password.',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        color: colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                         
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          'Reset Password',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Delete Account Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Delete Account',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'The data from your account will be deleted.',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        color: colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                      onPressed: () {
                         
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.error.withOpacity(0.2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          'Delete Account',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            color: colorScheme.error,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 48),
                // Hidden Email Field (if needed)
                // If you want to display the email, you can replace this with a Text widget
                // TextFormField(
                //   controller: emailController,
                //   focusNode: emailFocusNode,
                //   autofocus: false,
                //   textCapitalization: TextCapitalization.none,
                //   readOnly: true,
                //   decoration: InputDecoration(
                //     labelText: 'Email Address',
                //     labelStyle: TextStyle(
                //       fontFamily: 'Inter',
                //       fontSize: 16,
                //       color: colorScheme.onBackground.withOpacity(0.6),
                //     ),
                //     enabledBorder: OutlineInputBorder(
                //       borderSide: BorderSide(
                //         color: colorScheme.surface,
                //         width: 1,
                //       ),
                //       borderRadius: BorderRadius.circular(8),
                //     ),
                //     focusedBorder: OutlineInputBorder(
                //       borderSide: BorderSide(
                //         color: colorScheme.primary,
                //         width: 1,
                //       ),
                //       borderRadius: BorderRadius.circular(8),
                //     ),
                //   ),
                //   style: TextStyle(
                //     fontFamily: 'Inter',
                //     fontSize: 16,
                //     color: colorScheme.onBackground,
                //   ),
                //   validator: (value) {
                //     // Add your validation logic if needed
                //     return null;
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EasyDebounce {
}
