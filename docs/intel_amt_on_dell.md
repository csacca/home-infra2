# Intel AMT on Dell Hardware

This is a personal reference for updating the ME firmware on Dell Optiplex 5050/7050 era Dells using CSME 11.

1. Install Windows 10

2. Go to Dell support and upgrade BIOS to most recent version
    - Note vPro firmware version

3. Install prerequisites:
    - Install python >= 3.7
    - Install dependencies: `pip3 install colorama crccheck pltable`
    - Install [7-Zip](https://www.7-zip.org/) to deal with rar files

4. Follow the Win-Raid [Intel (Converged Security) Management Engine: Drivers, Firmware and Tools for (CS)ME 2-15](https://winraid.level1techs.com/t/intel-converged-security-management-engine-drivers-firmware-and-tools-2-15/30719) guide.
    - Download [HWiNFO](https://www.hwinfo.com/download/) to identify the running Intel ME Version.
    - Note major and minor version from HWiNFO -> Motherboard -> Intel ME -> Intel ME Version
    - Download the Intel CSME System Tools for your Intel ME major/minor version.

5. Follow the Win-Raid [Clean Dumped Intel Engine (CS)ME/(CS)TXE Regions with Data Initialization](https://winraid.level1techs.com/t/guide-clean-dumped-intel-engine-cs-me-cs-txe-regions-with-data-initialization/31277) guide.
    - Download [ME Analyzer](https://github.com/platomav/MEAnalyzer)
    - Extract (CS)ME tools rar file to a reasonable location

6. Shutdown system and set Service Mode jumper to enable read/write access to the SPI Flash.
    - Using an elevated command prompt, in CSME tools, use the Flash Programing Tool `FPTW64.exe` to dump the flash
        - `FPTW64.exe -d dump.bin`
    - Check dump with ME Analyzer
        - `python MEA.py dump.bin`
    - In order to verify that the SPI/BIOS dump has Initialization data, make sure that File System State is reported as "Initialized".

7. From [Intel (CS)ME, (CS)TXE, (CS)SPS, GSC, PMC, PCHC, PHY & OROM Firmware Repositories](https://winraid.level1techs.com/t832f39-Intel-Engine-Firmware-Repositories.html),
   download the correct Repository pack based on major/minor version and extract it. Rename correct firmware file as specified in guide.

8. Run the Flash Image Tool.
    - Open dump image to be cleaned.
    - In Build Settings, set Generate Intermediate Files to No.
    - Go to Save As and save the configuration xml file and close FIT.
    - In the dump Decomp folder, replace the ME Region binary with the clean one that was downloaded.
    - Reopen FIT and open the saved config xml file.
    - In FIT under the Intel AMT tab, set the following options:
        - Intel AMT Supported: Yes
        - Intel ME Network Services: Yes
        - Manageability Application Supported: Yes
        - Manageability Application initial power-up state: Enabled
        - KVM Redirection Supported: Yes
        - Transport Layer Security Supported: Yes
    - Save configuration, then build new image.
    - Run the built `outimage.bin` through ME Analyzer and verify File System State is listed as "Configured".

9. Flash the built image
    - Using an elevated command prompt, in CSME tools, use the Flash Programing Tool `FPTW64.exe` to write the new flash image
        - `FPTW64.exe -f outimage.bin`
    - Then issue a global reset to reinitialize the engine (machine will reboot).
        - `FPTW64.exe -greset`
    - After reboot, showdown machine and set the Service Mode jumper back to it's original position
    - Boot, wait for engine to initialize (reboots).
    - After boot, use HWiNFO64 to verify AMT is enabled.

10. Reboot and use F12 to enter the Intel Management Engine BIOS Extension (MBEx) menu.
    - Default password is "admin"
    - Set User Consent -> User Opt-in: None
    - Configure network settings
    - Activate Network Access
    - Boot machine

11. Use MeshCommander to verify remote access
