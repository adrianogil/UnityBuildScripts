/*
AutoBuilder.cs
Automatically builds the projects targetting a given platform.

Usage
- Place this script in an Editor folder.
- These methods can be launched by Unity command line using -executeMethod AutoBuilder.MethodName.
 */
using UnityEngine;
using UnityEditor;
using System.Collections;
using System.Collections.Generic;
using System.IO;

public static class AutoBuilder {

	static string GetProjectName()
	{
		string[] s = Application.dataPath.Split('/');
		return s[s.Length - 2];
	}

	static string[] GetScenePaths()
	{
		List<string> scenePaths = new List<string>();

		List<string> scenePaths = new List<string>();

		EditorBuildSettingsScene[] allScenes = EditorBuildSettings.scenes;
	    Debug.Log ("All Scenes : Length : "+allScenes.Length);
	    string path;
	    for (int i = 0; i < allScenes.Length; i++) {
	    	if (allScenes[i].enabled) {
		        // Debug.Log ("All Path : Scene : "+allScenes[i].path);
		        scenePaths.Add(allScenes[i].path);
	     	}
	     }

		return scenePaths.ToArray();
	}

	[MenuItem("File/AutoBuilder/Windows/32-bit")]
	static void PerformWinBuild ()
	{
		EditorUserBuildSettings.SwitchActiveBuildTarget(BuildTarget.StandaloneWindows);
		BuildPipeline.BuildPlayer(GetScenePaths(), "Builds/Win/" + GetProjectName() + ".exe",BuildTarget.StandaloneWindows,BuildOptions.None);
	}

	[MenuItem("File/AutoBuilder/Windows/64-bit")]
	static void PerformWin64Build ()
	{
		EditorUserBuildSettings.SwitchActiveBuildTarget(BuildTarget.StandaloneWindows);
		BuildPipeline.BuildPlayer(GetScenePaths(), "Builds/Win64/" + GetProjectName() + ".exe",BuildTarget.StandaloneWindows64,BuildOptions.None);
	}

	[MenuItem("File/AutoBuilder/Mac OSX/Universal")]
	static void PerformOSXUniversalBuild ()
	{
		EditorUserBuildSettings.SwitchActiveBuildTarget(BuildTarget.StandaloneOSXUniversal);
		BuildPipeline.BuildPlayer(GetScenePaths(), "Builds/OSX-Universal/" + GetProjectName() + ".app",BuildTarget.StandaloneOSXUniversal,BuildOptions.None);
	}

	[MenuItem("File/AutoBuilder/Mac OSX/Intel")]
	static void PerformOSXIntelBuild ()
	{
		EditorUserBuildSettings.SwitchActiveBuildTarget(BuildTarget.StandaloneOSXIntel);
		BuildPipeline.BuildPlayer(GetScenePaths(), "Builds/OSX-Intel/" + GetProjectName() + ".app",BuildTarget.StandaloneOSXIntel,BuildOptions.None);
	}

	[MenuItem("File/AutoBuilder/iOS")]
	static void PerformiOSBuild ()
	{
		EditorUserBuildSettings.SwitchActiveBuildTarget(BuildTarget.iOS);
		BuildPipeline.BuildPlayer(GetScenePaths(), "Builds/iOS",BuildTarget.iOS,BuildOptions.None);
	}
	[MenuItem("File/AutoBuilder/Android")]
	static void PerformAndroidBuild ()
	{
		string[] commands = System.Environment.GetCommandLineArgs ();
		string sufix_name = "";

		if (commands.Length > 1)
			sufix_name = commands [commands.Length-1];

		string project_apk_name = "app_project";

		EditorUserBuildSettings.SwitchActiveBuildTarget(BuildTarget.Android);
		PlayerSettings.Android.keystoreName = "Assets/Plugins/Android/platform.keystore";
		PlayerSettings.Android.keystorePass = "password";
		PlayerSettings.Android.keyaliasName = "debugkey";
		PlayerSettings.Android.keyaliasPass = "password";
		BuildPipeline.BuildPlayer(GetScenePaths(), "Builds/Android/" + project_apk_name + sufix_name + ".apk",
												BuildTarget.Android,BuildOptions.None);
	}

	static void PerformAndroidBuild2D ()
	{
		string[] commands = System.Environment.GetCommandLineArgs ();
		string sufix_name = "";

		if (commands.Length > 1)
			sufix_name = commands [commands.Length-1];

		string project_apk_name = "app_project_2d";

		EditorUserBuildSettings.SwitchActiveBuildTarget(BuildTarget.Android);

		PlayerSettings.productName = "App 2D";
		PlayerSettings.bundleIdentifier = "com.project.app2d";
		PlayerSettings.virtualRealitySupported = false;
		PlayerSettings.defaultInterfaceOrientation = UIOrientation.LandscapeRight;

		PlayerSettings.Android.keystoreName = "Assets/Plugins/Android/platform.keystore";
		PlayerSettings.Android.keystorePass = "password";
		PlayerSettings.Android.keyaliasName = "debugkey";
		PlayerSettings.Android.keyaliasPass = "password";

		BuildPipeline.BuildPlayer(GetScenePaths(), "Builds/Android/" + project_apk_name + sufix_name + ".apk",
												BuildTarget.Android,BuildOptions.None);
	}

	[MenuItem("File/AutoBuilder/Web/Standard")]
	static void PerformWebBuild ()
	{
		EditorUserBuildSettings.SwitchActiveBuildTarget(BuildTarget.WebPlayer);
		BuildPipeline.BuildPlayer(GetScenePaths(), "Builds/Web",BuildTarget.WebPlayer,BuildOptions.None);
	}
	[MenuItem("File/AutoBuilder/Web/Streamed")]
	static void PerformWebStreamedBuild ()
	{
		EditorUserBuildSettings.SwitchActiveBuildTarget(BuildTarget.WebPlayerStreamed);
		BuildPipeline.BuildPlayer(GetScenePaths(), "Builds/Web-Streamed",BuildTarget.WebPlayerStreamed,BuildOptions.None);
	}
}