
VFSManager v0.9.5.2 (BETA)
ColdFusion Administrator Version 
This version of the VFS Manager is designed to work inside the ColdFusion administrator.

Introduction
  This application is for browsing, deleting, and downloading data stored in VFS (virtual file system).

Requirements
1. ColdFusion 9 (does not function in earlier versions of CF)
 

Known Issues:
1. At times JS errors are thrown during load. This is due to a timing issue of when the tree is loaded
and when the main body loads.  
2. Zip downloading could fail if VFS does not have enough space to store zip file.


Installation:

1: Put VFSFolder in CFIDE/Administrator folder.
2: Update custommenu.xml in CFIDE/Administrator with the code from vfsmanager/config/custommenu.xml.
	NOTE: If you already have a custom menu setup the make the necessary changes to your custommenu.xml.
3: Log into the ColdFusion Administrator. At the bottom of the left menu there should be a "custom server settings" section.  Inside of that there will be a "VFS Manager" link.  


