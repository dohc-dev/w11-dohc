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
