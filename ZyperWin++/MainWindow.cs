using Sunny.UI;
using System.Drawing;
using System.Windows.Forms;

namespace ZyperWin__
{
    public partial class MainWindow : UIForm
    {
        public MainMenu f1;
        public kuaisuyouhua f2;
        public guanyuruanjian f3;
        public explorer f4;
        public xingneng f5;
        public edge f6;
        public safe f7;
        public yinsi f8;
        public update f9;
        public fuwu f10;
        public laji f11;
        public office f12;
        public jihuo f13;
        public appx f14;
        public recover f15;
        public static UITreeView SharedTreeView;
        protected override CreateParams CreateParams
        {
            get
            {
                if (DesignMode)
                {
                    return base.CreateParams;
                }
                CreateParams paras = base.CreateParams;
                paras.ExStyle |= 0x02000000;
                return paras;
            }
        }
        public MainWindow()
        {
            this.AutoScaleMode = AutoScaleMode.Dpi;
            this.AutoScaleDimensions = new SizeF(96F, 96F);
            InitializeComponent();
            SharedTreeView = uiTreeView1;

            // 先初始化 f1
            f1 = new MainMenu();

            f1.Show();
            uiPanel1.Controls.Clear();
            uiPanel1.Controls.Add(f1);
        }

        private void uiTreeView1_AfterSelect(object sender, TreeViewEventArgs e)
        {
            uiTreeView1.ExpandAll();

            if (e.Node.Text.ToString() == "主页")
            {
                f1 = new MainMenu();
                uiPanel1.Controls.Clear();
                uiPanel1.Controls.Add(f1);
            }

            if (e.Node.Text.ToString() == "快速优化")
            {
                f2 = new kuaisuyouhua();
                uiPanel1.Controls.Clear();
                uiPanel1.Controls.Add(f2);
            }

            if (e.Node.Text.ToString() == "关于软件")
            {
                f3 = new guanyuruanjian();
                uiPanel1.Controls.Clear();
                uiPanel1.Controls.Add(f3);
            }

            if (e.Node.Text.ToString() == "外观/资源管理器")
            {
                f4 = new explorer();
                uiPanel1.Controls.Clear();
                uiPanel1.Controls.Add(f4);
            }

            if (e.Node.Text.ToString() == "性能优化设置")
            {
                f5 = new xingneng();
                uiPanel1.Controls.Clear();
                uiPanel1.Controls.Add(f5);
            }

            if (e.Node.Text.ToString() == "Edge优化设置")
            {
                f6 = new edge();
                uiPanel1.Controls.Clear();
                uiPanel1.Controls.Add(f6);
            }

            if (e.Node.Text.ToString() == "安全设置")
            {
                f7 = new safe();
                uiPanel1.Controls.Clear();
                uiPanel1.Controls.Add(f7);
            }

            if (e.Node.Text.ToString() == "隐私设置")
            {
                f8 = new yinsi();
                uiPanel1.Controls.Clear();
                uiPanel1.Controls.Add(f8);
            }

            if (e.Node.Text.ToString() == "更新设置")
            {
                f9 = new update();
                uiPanel1.Controls.Clear();
                uiPanel1.Controls.Add(f9);
            }

            if (e.Node.Text.ToString() == "服务项优化")
            {
                f10 = new fuwu();
                uiPanel1.Controls.Clear();
                uiPanel1.Controls.Add(f10);
            }

            if (e.Node.Text.ToString() == "垃圾清理")
            {
                f11 = new laji();
                uiPanel1.Controls.Clear();
                uiPanel1.Controls.Add(f11);
            }

            if (e.Node.Text.ToString() == "Office安装")
            {
                f12 = new office();
                uiPanel1.Controls.Clear();
                uiPanel1.Controls.Add(f12);
            }

            if (e.Node.Text.ToString() == "系统激活")
            {
                f13 = new jihuo();
                uiPanel1.Controls.Clear();
                uiPanel1.Controls.Add(f13);
            }

            if (e.Node.Text.ToString() == "Appx管理")
            {
                f14 = new appx();
                uiPanel1.Controls.Clear();
                uiPanel1.Controls.Add(f14);
            }

            if (e.Node.Text.ToString() == "优化还原")
            {
                f15 = new recover();
                uiPanel1.Controls.Clear();
                uiPanel1.Controls.Add(f15);
            }
        }
    }
}
