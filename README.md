## Debugmode  
Description: Simple [SA:MP](https://www.sa-mp.com/) gamemode created for debugging purposes.  
Perfect if you need to quickly deploy a samp server and test any system.  
> Based on [SA:MP 0.3.7 R2 server](https://www.sa-mp.com/download.php)  

### Configure
- Check before run [server.cfg](https://open.mp/docs/server/server.cfg) configfile.  
- Compile your script with [debug info](https://github.com/Zeex/samp-plugin-crashdetect/wiki/Compiling-scripts-with-debug-info).
- CrashDetect does not work in conjunction with Profiler and JIT plugins, only one of them can be used!

### Contain plugins
* [Crashdetect 4.19 plugin](https://github.com/Zeex/samp-plugin-crashdetect/releases)
* [Sscanf 2.8 plugin](https://github.com/Y-Less/sscanf/releases)
* [Profiler 2.15 plugin](https://github.com/Zeex/samp-plugin-profiler)

### Filterscripts
Contains only the necessary filterscripts:
- afly, attachments, flymode, fs_cmds, fsdebug  
- http_test, menutest, netstats, npc_record, ospawner  
- pnetstats, pnetstats2, samp_anims, skinchanger  
- specbar, test_cmds, vae, vspawner  

### Default commands
* /respawn, /class, /kill, /slapme, /jetpack, /tpc  
> To use more loadfs **test_cmds**  
