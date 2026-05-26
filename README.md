# komorebi Setup


# 1 - Disable Winkeys

You can disable standard Windows Key shortcuts (like `Win + E`, `Win + R`, etc.) using the Local Group Policy Editor (`gpedit.msc`).

> ⚠️ **Note:** This policy disables most global Windows hotkeys, but some critical system shortcuts (like `Win + L` to lock the PC or `Win + Alt + Del`) will remain active for security reasons. Group Policy Editor is also only available on Windows Pro, Enterprise, and Education editions.

Here is the step-by-step guide to turning them off:

### Step 1: Open the Group Policy Editor

1. Press the **Windows Key + R** on your keyboard to open the Run dialog box.
2. Type `gpedit.msc` and press **Enter** (or click OK).

### Step 2: Navigate to the Explorer Settings

In the left sidebar of the Group Policy Editor, navigate through the folders using the following path:

* **User Configuration** * 📂 **Administrative Templates** * 📂 **Windows Components** * 📂 **File Explorer** *(Note: On older versions of Windows, this may be called **Windows Explorer**)*

### Step 3: Enable the "Turn off Windows Key hotkeys" Policy

1. Once you click on **File Explorer**, look at the right-hand pane and scroll down to find the setting named: **Turn off Windows Key hotkeys**.
2. **Double-click** on it to open its properties window.
3. In the top-left corner of the window, change the selection from *Not Configured* to **Enabled**.
4. Click **Apply** and then click **OK**.

---

### Step 4: Apply the Changes

The changes usually take effect immediately, but if the shortcuts are still working, you can force Windows to refresh the policies without restarting your PC:

1. Right-click the Start button and select **Terminal** or **Command Prompt**.
2. Type `gpupdate /force` and press **Enter**.

If you ever want to re-enable the Windows key shortcuts in the future, simply repeat these steps and change the setting back to **Not Configured** or **Disabled**.

---

### Complete Removal: Disable the Physical Windows Key

The Group Policy method above doesn't disable a bare Windows key tap (which still opens Start). For complete removal, use the registry-based Scancode Map:

**To disable:**
1. Right-click Start, select **Terminal** or **Command Prompt** and choose **Run as administrator**
2. Paste and run:
   ```
   reg add "HKLM\SYSTEM\CurrentControlSet\Control\Keyboard Layout" /v "Scancode Map" /t REG_BINARY /d 00000000000000000300000000005BE000005CE000000000 /f
   ```
3. Restart your PC

**To undo:**
```
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Keyboard Layout" /v "Scancode Map" /f
```

This completely disables both Windows keys with zero performance overhead. You can still open Start by clicking the taskbar icon.

### Disable Win + L (Lock Workstation)

**To disable:**
1. Right-click Start, select **Terminal** or **Command Prompt** and choose **Run as administrator**
2. Paste and run:
   ```
   reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableLockWorkstation /t REG_DWORD /d 1 /f
   ```
3. Restart your PC

**To undo:**
```
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableLockWorkstation /f
```

---

# 2 - Get latest applications.json from the community

Run the sync script from the repo root to pull the latest `applications.json` from the community repo and refresh both this repo's copy and the active file at `$Env:USERPROFILE\applications.json`:

```powershell
.\scripts\sync-applications-json.ps1
```

# 3 - Windhawk + RoundedTB

[Windhawk](https://windhawk.net/) is a customization tool for Windows, paired with [RoundedTB Community Edition](https://github.com/PeterMaZep/RoundedTB-Community-edition) for advanced taskbar styling.

### Windhawk Mods

- **Taskbar Fade** — Automatically dims or hides the taskbar when idle. Reduces visual clutter and prevents OLED burn-in.
- **Taskbar height and icon size** — Control taskbar height and icon size with improved icon quality (Windows 11 only).
- **Taskbar Z-Order Override** — Control whether the taskbar stays always on top, always at the bottom, or behaves like a normal window.
- **Windows 11 Notification Center Styler** — Customize the Notification Center and Action Center with community themes or create your own.
- **Windows 11 Start Menu Styler** — Customize the Start menu with community themes or create your own.
- **Windows 11 Taskbar Styler** — Customize the taskbar with community themes or create your own.

### RoundedTB Community Edition

Install [RoundedTB Community Edition](https://github.com/PeterMaZep/RoundedTB-Community-edition) for additional taskbar customization options that work alongside Windhawk.