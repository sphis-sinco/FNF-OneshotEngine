package ose;

import ose.macros.GitCommit;

class Global
{
	public static var OSEVersion:String = '1.0 (${GitCommit.getGitCommitHash()})${#if debug ' PROTOTYPE' #else '' #end}';
	public static var OSEWatermarkString:String = 'OSE';
	public static var OSEWatermark:String = '$OSEWatermarkString $OSEVersion';
}
