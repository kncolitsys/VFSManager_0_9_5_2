
VFSManager v0.9.5.2 (BETA)
Stand-alone Version
This version of the VFS Manager was designed to work as a stand-alone application.

Introduction
  This application is for browsing, deleting, and downloading data stored in VFS (virtual file system).

Requirements
1. ColdFusion 9 (does not function in earlier versions of CF)
 

Known Issues:
1. At times JS errors are thrown during load. This is due to a timing issue of when the tree is loaded
and when the main body loads.  
2. Zip downloading could fail if VFS does not have enough space to store zip file.


Installation:
1: Copy the VFSFolder from the "VFSManager Standalone" directory to the web root folder... "http://siteurl/VFSManager".  Will not work if not in root.
2: Login is admin:admin.  Can be changed via config file found in /VFSManager/config/config.txt.cfm


