import 'package:account_manager/ui/features/backup_restore/backup_restore_cubit.dart';
import 'package:account_manager/utils/toaster.dart';
import 'package:account_manager/widgets/primary_button.dart';
import 'package:account_manager/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import '../../../network/google_drive_app_data.dart';

class BackupNRestoreScreen extends StatefulWidget {
  const BackupNRestoreScreen({Key? key}) : super(key: key);

  @override
  State<BackupNRestoreScreen> createState() => _BackupNRestoreScreenState();
}

class _BackupNRestoreScreenState extends State<BackupNRestoreScreen> {
  @override
  void initState() {
    BlocProvider.of<BackupRestoreCubit>(context).initUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Backup and Restore"),
          ),
          body: BlocConsumer<BackupRestoreCubit, BackupRestoreState>(
            listener: (_, state) {},
            builder: (_, state) {
              if (state is NoUserSignedIn) {
                return SignInUI();
              } else if (state is UserSignedIn) {
                return BackupRestoreUI();
              } else if (state is LoadingUI) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is NoInternet) {
                return const Center(
                  child: Text("No Internet"),
                );
              } else {
                return const Center(
                  child: Text("Something went wrong !!!"),
                );
              }
            },
            buildWhen: (previous, current) {
              if (current is NoUserSignedIn ||
                  current is UserSignedIn ||
                  current is LoadingUI ||
                  current is Error ||
                  current is NoInternet) {
                return true;
              }
              return false;
            },
          ),
        ));
  }
}

class SignInUI extends StatefulWidget {
  const SignInUI({Key? key}) : super(key: key);

  @override
  State<SignInUI> createState() => _SignInUIState();
}

class _SignInUIState extends State<SignInUI> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.phone_android,
                size: 70,
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Icon(Icons.sync),
              ),
              Icon(
                Icons.add_to_drive_rounded,
                size: 70,
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          const Text(
            "Sign In with Google Drive to backup and restore data",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          BlocBuilder<BackupRestoreCubit, BackupRestoreState>(
            buildWhen: (previous, current) {
              if (current is SigningIn || current is NoUserSignedIn) {
                return true;
              }
              return false;
            },
            builder: (context, state) {
              if (state is SigningIn) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<BackupRestoreCubit>(context)
                        .signInWithGoogle();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text("Sign In with Google"),
                  ));
            },
          )
        ],
      ),
    );
  }
}

class BackupRestoreUI extends StatefulWidget {
  const BackupRestoreUI({Key? key}) : super(key: key);

  @override
  State<BackupRestoreUI> createState() => _BackupRestoreUIState();
}

class _BackupRestoreUIState extends State<BackupRestoreUI> {

  @override
  void initState() {
    BlocProvider.of<BackupRestoreCubit>(context).loadBackups();
    super.initState();
  }


  void showLoadingDialog(String msg){
    // show the loading dialog
    showDialog(
      // The user CANNOT close this dialog  by pressing outsite it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // The loading indicator
                  const CircularProgressIndicator(),
                  const SizedBox(
                    height: 16,
                  ),
                  // Some text
                  Text(msg)
                ],
              ),
            ),
          );
        });

  }
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: BlocListener<BackupRestoreCubit, BackupRestoreState>(
        listener: (context, state) {

          if(state is BackingUp){
            showLoadingDialog("Backing Up...");
          }


          if(state is Restoring){
            showLoadingDialog("Restoring...");
          }
          if(state is BackupSuccessful){
            Navigator.of(context).pop();
            showToast("Backup Successful!!!",ToastType.success);
          }
          if(state is RestoreSuccessful){
            Navigator.of(context).pop();
            showToast("Restoration Successful!!!",ToastType.success);
          }
          if(state is BackupFailed){
            Navigator.of(context).pop();
            showToast("Backup Failed!!!",ToastType.error);
          }

          if(state is RestorationFailed){
            Navigator.of(context).pop();
            showToast("Restoration Failed!!!",ToastType.error);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [
            BlocBuilder<BackupRestoreCubit, BackupRestoreState>(
                buildWhen: (previous, current) {
                  if (current is LoadingBackupHistory ||
                      current is ReceivedBackupVersions ||
                      current is NoBackupFound) {
                    return true;
                  }
                  return false;
                },
                builder: (_, state) {
                  if (state is LoadingBackupHistory) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ReceivedBackupVersions) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.cloud_done,size: 100,),
                        const SizedBox(height: 16,),
                        Text("Last backup taken on ${state.file.modifiedTime}",textAlign: TextAlign.center,style:const TextStyle(fontWeight: FontWeight.w500,fontSize: 18),)
                      ],
                    );
                  } else {
                    return const Center(child: Text("No Backup Found !!!"),);
                  }
                }),
            const Spacer(),
            PrimaryButton(
              onClick: () {
                BlocProvider.of<BackupRestoreCubit>(context).backupNow();
              },
              text: 'Backup Now',
            ),
            const SizedBox(
              height: 16,
            ),
            PrimaryButton(
              onClick: () {
                BlocProvider.of<BackupRestoreCubit>(context).restoreBackup();
              },
              text: 'Restore',
            ),
            const SizedBox(
              height: 16,
            ),
            SecondaryButton(
                onClick: () {
                  BlocProvider.of<BackupRestoreCubit>(context).signOut();
                },
                text: "Sign Out")
          ],
        ),
      ),
    );
  }
}
