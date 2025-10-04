namespace ZyperWin__
{
    partial class question
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

        #region 组件设计器生成的代码

        /// <summary> 
        /// 设计器支持所需的方法 - 不要修改
        /// 使用代码编辑器修改此方法的内容。
        /// </summary>
        private void InitializeComponent()
        {
            this.collapse1 = new AntdUI.Collapse();
            this.collapseItem1 = new AntdUI.CollapseItem();
            this.label1 = new System.Windows.Forms.Label();
            this.collapseItem2 = new AntdUI.CollapseItem();
            this.label2 = new System.Windows.Forms.Label();
            this.collapseItem3 = new AntdUI.CollapseItem();
            this.label3 = new System.Windows.Forms.Label();
            this.collapseItem4 = new AntdUI.CollapseItem();
            this.label4 = new System.Windows.Forms.Label();
            this.collapseItem5 = new AntdUI.CollapseItem();
            this.label5 = new System.Windows.Forms.Label();
            this.collapse1.SuspendLayout();
            this.collapseItem1.SuspendLayout();
            this.collapseItem2.SuspendLayout();
            this.collapseItem3.SuspendLayout();
            this.collapseItem4.SuspendLayout();
            this.collapseItem5.SuspendLayout();
            this.SuspendLayout();
            // 
            // collapse1
            // 
            this.collapse1.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.collapse1.BorderWidth = 0F;
            this.collapse1.Cursor = System.Windows.Forms.Cursors.Hand;
            this.collapse1.Font = new System.Drawing.Font("微软雅黑", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.collapse1.Items.Add(this.collapseItem1);
            this.collapse1.Items.Add(this.collapseItem2);
            this.collapse1.Items.Add(this.collapseItem3);
            this.collapse1.Items.Add(this.collapseItem4);
            this.collapse1.Items.Add(this.collapseItem5);
            this.collapse1.Location = new System.Drawing.Point(0, 0);
            this.collapse1.Name = "collapse1";
            this.collapse1.Size = new System.Drawing.Size(717, 501);
            this.collapse1.TabIndex = 0;
            this.collapse1.Text = "collapse1";
            this.collapse1.Unique = true;
            this.collapse1.UniqueFull = true;
            // 
            // collapseItem1
            // 
            this.collapseItem1.Controls.Add(this.label1);
            this.collapseItem1.IconSvg = "ApiOutlined";
            this.collapseItem1.Location = new System.Drawing.Point(-679, -233);
            this.collapseItem1.Name = "collapseItem1";
            this.collapseItem1.Size = new System.Drawing.Size(679, 233);
            this.collapseItem1.TabIndex = 0;
            this.collapseItem1.Tag = "";
            this.collapseItem1.Text = "问题一：优化后xxx游戏打不开，反作弊打不开，怎么回事？";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.label1.Font = new System.Drawing.Font("微软雅黑", 11.5F);
            this.label1.Location = new System.Drawing.Point(0, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(453, 63);
            this.label1.TabIndex = 0;
            this.label1.Text = "A：这是因为优化禁用了内存完整性、缩短关闭服务相关功能，\r\n     设置过短导致相关服务被强制终止。\r\n     到系统优化找到相关选项还原所选重启即可。\r\n";
            // 
            // collapseItem2
            // 
            this.collapseItem2.Controls.Add(this.label2);
            this.collapseItem2.IconSvg = "CloseSquareOutlined";
            this.collapseItem2.Location = new System.Drawing.Point(-679, -233);
            this.collapseItem2.Name = "collapseItem2";
            this.collapseItem2.Size = new System.Drawing.Size(679, 233);
            this.collapseItem2.TabIndex = 1;
            this.collapseItem2.Text = "问题二：优化后会蓝屏，怎么回事？";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.label2.Location = new System.Drawing.Point(0, 0);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(649, 84);
            this.label2.TabIndex = 1;
            this.label2.Text = "A：查着蓝屏代码，驱动问题请更新驱动，系统问题尝试还原优化设置\r\n   （优化后会备份优化设置，导入配置后“还原所选”就行），或者系统更到最新版看看。\r\n    " +
    "这得结合多个因素反馈，建议查看系统日志逐步分析。\r\n    实在不行找官方ISO镜像覆盖安装或者重装系统。\r\n";
            // 
            // collapseItem3
            // 
            this.collapseItem3.Controls.Add(this.label3);
            this.collapseItem3.IconSvg = "FolderOutlined";
            this.collapseItem3.Location = new System.Drawing.Point(-679, -233);
            this.collapseItem3.Name = "collapseItem3";
            this.collapseItem3.Size = new System.Drawing.Size(679, 233);
            this.collapseItem3.TabIndex = 2;
            this.collapseItem3.Text = "问题三：优化后资源管理器会卡死，只显示鼠标，怎么回事？";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Dock = System.Windows.Forms.DockStyle.Fill;
            this.label3.Location = new System.Drawing.Point(0, 0);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(601, 84);
            this.label3.TabIndex = 0;
            this.label3.Text = "A：建议还原设置（优化后会备份优化设置，导入配置后“还原所选”就行）\r\n     或者使用经典资源管理器，或者系统更新看一下\r\n   （阿三特性，之前有小伙伴反馈" +
    "，后来更新系统解决。这个现象同样测试没问题）\r\n     实在不行找官方ISO镜像覆盖安装或者重装系统。";
            // 
            // collapseItem4
            // 
            this.collapseItem4.Controls.Add(this.label4);
            this.collapseItem4.IconSvg = "FrownOutlined";
            this.collapseItem4.Location = new System.Drawing.Point(-679, -233);
            this.collapseItem4.Name = "collapseItem4";
            this.collapseItem4.Size = new System.Drawing.Size(679, 233);
            this.collapseItem4.TabIndex = 3;
            this.collapseItem4.Text = "问题四：优化后变卡顿，不咋样，怎么回事？";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Dock = System.Windows.Forms.DockStyle.Fill;
            this.label4.Location = new System.Drawing.Point(0, 0);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(617, 63);
            this.label4.TabIndex = 0;
            this.label4.Text = "A: 这款软件一般通过注册表关闭一些非必要服务进程，若觉得优化不好可以还原\r\n   （优化后会备份优化设置，导入配置后“还原所选”就行）或者一个一个排查调节。\r\n" +
    "    实在不行建议您换别的优化软件，谢谢。\r\n";
            // 
            // collapseItem5
            // 
            this.collapseItem5.Controls.Add(this.label5);
            this.collapseItem5.IconSvg = "QuestionOutlined";
            this.collapseItem5.Location = new System.Drawing.Point(-679, -233);
            this.collapseItem5.Name = "collapseItem5";
            this.collapseItem5.Size = new System.Drawing.Size(679, 233);
            this.collapseItem5.TabIndex = 4;
            this.collapseItem5.Text = "没有您出现的问题？";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Dock = System.Windows.Forms.DockStyle.Fill;
            this.label5.Location = new System.Drawing.Point(0, 0);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(395, 63);
            this.label5.TabIndex = 0;
            this.label5.Text = "A：请加入群聊进行问题交流反馈。\r\n     群1：312820776，群2：374617605\r\n   （若群1满了请加入群2，资源有限不要重复入群。）";
            // 
            // question
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.collapse1);
            this.Font = new System.Drawing.Font("微软雅黑", 10.5F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.Name = "question";
            this.Size = new System.Drawing.Size(717, 501);
            this.collapse1.ResumeLayout(false);
            this.collapseItem1.ResumeLayout(false);
            this.collapseItem1.PerformLayout();
            this.collapseItem2.ResumeLayout(false);
            this.collapseItem2.PerformLayout();
            this.collapseItem3.ResumeLayout(false);
            this.collapseItem3.PerformLayout();
            this.collapseItem4.ResumeLayout(false);
            this.collapseItem4.PerformLayout();
            this.collapseItem5.ResumeLayout(false);
            this.collapseItem5.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private AntdUI.Collapse collapse1;
        private AntdUI.CollapseItem collapseItem1;
        private System.Windows.Forms.Label label1;
        private AntdUI.CollapseItem collapseItem2;
        private System.Windows.Forms.Label label2;
        private AntdUI.CollapseItem collapseItem3;
        private System.Windows.Forms.Label label3;
        private AntdUI.CollapseItem collapseItem4;
        private System.Windows.Forms.Label label4;
        private AntdUI.CollapseItem collapseItem5;
        private System.Windows.Forms.Label label5;
    }
}
