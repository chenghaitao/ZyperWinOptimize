namespace ZyperWin__
{
    partial class MainWindow
    {
        /// <summary>
        /// 必需的设计器变量。
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// 清理所有正在使用的资源。
        /// </summary>
        /// <param name="disposing">如果应释放托管资源，为 true；否则为 false。</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows 窗体设计器生成的代码

        /// <summary>
        /// 设计器支持所需的方法 - 不要修改
        /// 使用代码编辑器修改此方法的内容。
        /// </summary>
        private void InitializeComponent()
        {
            System.Windows.Forms.TreeNode treeNode1 = new System.Windows.Forms.TreeNode("主页");
            System.Windows.Forms.TreeNode treeNode2 = new System.Windows.Forms.TreeNode("快速优化");
            System.Windows.Forms.TreeNode treeNode3 = new System.Windows.Forms.TreeNode("外观/资源管理器");
            System.Windows.Forms.TreeNode treeNode4 = new System.Windows.Forms.TreeNode("性能优化设置");
            System.Windows.Forms.TreeNode treeNode5 = new System.Windows.Forms.TreeNode("Edge优化设置");
            System.Windows.Forms.TreeNode treeNode6 = new System.Windows.Forms.TreeNode("安全设置");
            System.Windows.Forms.TreeNode treeNode7 = new System.Windows.Forms.TreeNode("隐私设置");
            System.Windows.Forms.TreeNode treeNode8 = new System.Windows.Forms.TreeNode("更新设置");
            System.Windows.Forms.TreeNode treeNode9 = new System.Windows.Forms.TreeNode("服务项优化");
            System.Windows.Forms.TreeNode treeNode10 = new System.Windows.Forms.TreeNode("自定义优化", new System.Windows.Forms.TreeNode[] {
            treeNode3,
            treeNode4,
            treeNode5,
            treeNode6,
            treeNode7,
            treeNode8,
            treeNode9});
            System.Windows.Forms.TreeNode treeNode11 = new System.Windows.Forms.TreeNode("优化还原");
            System.Windows.Forms.TreeNode treeNode12 = new System.Windows.Forms.TreeNode("垃圾清理");
            System.Windows.Forms.TreeNode treeNode13 = new System.Windows.Forms.TreeNode("Office安装");
            System.Windows.Forms.TreeNode treeNode14 = new System.Windows.Forms.TreeNode("系统激活");
            System.Windows.Forms.TreeNode treeNode15 = new System.Windows.Forms.TreeNode("Appx管理");
            System.Windows.Forms.TreeNode treeNode16 = new System.Windows.Forms.TreeNode("其他功能", new System.Windows.Forms.TreeNode[] {
            treeNode12,
            treeNode13,
            treeNode14,
            treeNode15});
            System.Windows.Forms.TreeNode treeNode17 = new System.Windows.Forms.TreeNode("关于软件");
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(MainWindow));
            this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
            this.uiTreeView1 = new Sunny.UI.UITreeView();
            this.uiPanel1 = new Sunny.UI.UIPanel();
            this.tableLayoutPanel1.SuspendLayout();
            this.SuspendLayout();
            // 
            // tableLayoutPanel1
            // 
            this.tableLayoutPanel1.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.tableLayoutPanel1.ColumnCount = 2;
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 21.89696F));
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 78.10304F));
            this.tableLayoutPanel1.Controls.Add(this.uiTreeView1, 0, 0);
            this.tableLayoutPanel1.Controls.Add(this.uiPanel1, 1, 0);
            this.tableLayoutPanel1.Location = new System.Drawing.Point(3, 35);
            this.tableLayoutPanel1.Name = "tableLayoutPanel1";
            this.tableLayoutPanel1.RowCount = 1;
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 504F));
            this.tableLayoutPanel1.Size = new System.Drawing.Size(854, 504);
            this.tableLayoutPanel1.TabIndex = 0;
            // 
            // uiTreeView1
            // 
            this.uiTreeView1.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.uiTreeView1.FillColor = System.Drawing.Color.White;
            this.uiTreeView1.FillColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(251)))), ((int)(((byte)(250)))));
            this.uiTreeView1.Font = new System.Drawing.Font("微软雅黑", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.uiTreeView1.HoverColor = System.Drawing.Color.FromArgb(((int)(((byte)(204)))), ((int)(((byte)(242)))), ((int)(((byte)(238)))));
            this.uiTreeView1.LineColor = System.Drawing.Color.FromArgb(((int)(((byte)(48)))), ((int)(((byte)(48)))), ((int)(((byte)(48)))));
            this.uiTreeView1.Location = new System.Drawing.Point(4, 5);
            this.uiTreeView1.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.uiTreeView1.MinimumSize = new System.Drawing.Size(1, 1);
            this.uiTreeView1.Name = "uiTreeView1";
            treeNode1.Name = "主页";
            treeNode1.Text = "主页";
            treeNode2.Name = "快速优化";
            treeNode2.Text = "快速优化";
            treeNode3.Name = "外观/资源管理器";
            treeNode3.Text = "外观/资源管理器";
            treeNode4.Name = "性能优化设置";
            treeNode4.Text = "性能优化设置";
            treeNode5.Name = "Edge优化设置";
            treeNode5.Text = "Edge优化设置";
            treeNode6.Name = "安全设置";
            treeNode6.Text = "安全设置";
            treeNode7.Name = "隐私设置";
            treeNode7.Text = "隐私设置";
            treeNode8.Name = "更新设置";
            treeNode8.Text = "更新设置";
            treeNode9.Name = "服务项优化";
            treeNode9.Text = "服务项优化";
            treeNode10.Name = "zidingyiyouhua";
            treeNode10.Text = "自定义优化";
            treeNode11.Name = "优化还原";
            treeNode11.Text = "优化还原";
            treeNode12.Name = "垃圾清理";
            treeNode12.Text = "垃圾清理";
            treeNode13.Name = "Office安装";
            treeNode13.Text = "Office安装";
            treeNode14.Name = "系统激活";
            treeNode14.Text = "系统激活";
            treeNode15.Name = "Appx管理";
            treeNode15.Text = "Appx管理";
            treeNode16.Name = "其他功能";
            treeNode16.Text = "其他功能";
            treeNode17.Name = "关于软件";
            treeNode17.Text = "关于软件";
            this.uiTreeView1.Nodes.AddRange(new System.Windows.Forms.TreeNode[] {
            treeNode1,
            treeNode2,
            treeNode10,
            treeNode11,
            treeNode16,
            treeNode17});
            this.uiTreeView1.RectColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(190)))), ((int)(((byte)(172)))));
            this.uiTreeView1.ScrollBarBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(251)))), ((int)(((byte)(250)))));
            this.uiTreeView1.ScrollBarColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(190)))), ((int)(((byte)(172)))));
            this.uiTreeView1.ScrollBarRectColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(190)))), ((int)(((byte)(172)))));
            this.uiTreeView1.ScrollBarStyleInherited = false;
            this.uiTreeView1.SelectedColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(190)))), ((int)(((byte)(172)))));
            this.uiTreeView1.ShowText = false;
            this.uiTreeView1.Size = new System.Drawing.Size(179, 494);
            this.uiTreeView1.Style = Sunny.UI.UIStyle.Custom;
            this.uiTreeView1.TabIndex = 0;
            this.uiTreeView1.Text = "uiTreeView1";
            this.uiTreeView1.TextAlignment = System.Drawing.ContentAlignment.MiddleCenter;
            this.uiTreeView1.AfterSelect += new System.Windows.Forms.TreeViewEventHandler(this.uiTreeView1_AfterSelect);
            // 
            // uiPanel1
            // 
            this.uiPanel1.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.uiPanel1.AutoSize = true;
            this.uiPanel1.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.uiPanel1.FillColor = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(251)))), ((int)(((byte)(250)))));
            this.uiPanel1.FillColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(251)))), ((int)(((byte)(250)))));
            this.uiPanel1.Font = new System.Drawing.Font("微软雅黑", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.uiPanel1.Location = new System.Drawing.Point(191, 5);
            this.uiPanel1.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.uiPanel1.MinimumSize = new System.Drawing.Size(1, 1);
            this.uiPanel1.Name = "uiPanel1";
            this.uiPanel1.RectColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(190)))), ((int)(((byte)(172)))));
            this.uiPanel1.Size = new System.Drawing.Size(659, 494);
            this.uiPanel1.Style = Sunny.UI.UIStyle.Custom;
            this.uiPanel1.TabIndex = 1;
            this.uiPanel1.Text = null;
            this.uiPanel1.TextAlignment = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // MainWindow
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(96F, 96F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Dpi;
            this.AutoSize = true;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(251)))), ((int)(((byte)(250)))));
            this.ClientSize = new System.Drawing.Size(860, 540);
            this.ControlBoxFillHoverColor = System.Drawing.Color.FromArgb(((int)(((byte)(51)))), ((int)(((byte)(203)))), ((int)(((byte)(189)))));
            this.Controls.Add(this.tableLayoutPanel1);
            this.Font = new System.Drawing.Font("Microsoft YaHei UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MaximizeBox = false;
            this.Name = "MainWindow";
            this.Padding = new System.Windows.Forms.Padding(0, 30, 0, 0);
            this.RectColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(190)))), ((int)(((byte)(172)))));
            this.Style = Sunny.UI.UIStyle.Custom;
            this.Text = "ZyperWin++ v3.0";
            this.TitleColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(190)))), ((int)(((byte)(172)))));
            this.TitleFont = new System.Drawing.Font("Microsoft YaHei UI", 10.5F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.TitleHeight = 30;
            this.ZoomScaleRect = new System.Drawing.Rectangle(15, 15, 800, 450);
            this.tableLayoutPanel1.ResumeLayout(false);
            this.tableLayoutPanel1.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
        private Sunny.UI.UITreeView uiTreeView1;
        private Sunny.UI.UIPanel uiPanel1;
    }
}

