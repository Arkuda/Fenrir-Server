using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;

namespace Fenrir
{
    static class Program
    {

        /// <summary>
        /// Главная точка входа для приложения.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);

            bool isDebug = true;
            Form1 frm = new Form1();
            if (isDebug)
            {
                frm.Opacity = 100;
                frm.ShowInTaskbar = true;
                frm.WindowState = FormWindowState.Normal;
            }
            else
            {
                frm.Opacity = 0;
                frm.ShowInTaskbar = false;
                frm.WindowState = FormWindowState.Minimized;
            }
           
            frm.printF("Welcome to Fenrir. The best.....");
            kit kit = new kit(frm);
            Application.Run(frm);
            
            
        }
    }
}
