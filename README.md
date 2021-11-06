这是一个用Rust中的warp框架做的网站（https://warp.wiki）


前端代码修改：
PC端注册页：
1.还需要做点击”获取验证码“后倒计时30秒后才可以再次点，相关JS代码请写在”注册页“
2.注册页还要做点击注册按纽时判断手机号码是否为手机号，才让提交注册表单，相关JS请写到”注册页“源码。
PC购物车-02.html
请增加地址选中效果，添加可点击切换选中另一个地址。
PC购物车-03.html
添加”银联支付“标签。





sudo grub-mkfont -v --output=/boot/grub/themes/Tela/DejaVuSansMono24.pf2 --size=24 /usr/share/fonts/truetype/dejavu/DejaVuSansMono.ttf
sudo grub-mkfont -v --output=/boot/grub/fonts/DejaVuSansMono24.pf2 --size=24 /usr/share/fonts/truetype/dejavu/DejaVuSansMono.ttf

luck@HP-ENVY-x360:/boot/grub/fonts$ sudo grub-mkfont -v --output=/boot/grub/fonts/DejaVuSansMono24.pf2 --size=24 /usr/share/fonts/truetype/dejavu/DejaVuSansMono.ttf
Font name: DejaVu Sans Mono Regular 24
Max width: 22
Max height: 29
Font ascent: 25
Font descent: 9
Number of glyph: 3452
luck@HP-ENVY-x360:/boot/grub/fonts$ 

 
制作字体，例如，

$ sudo grub2-mkfont --output=/boot/grub/fonts/robotomedium.pf2 --size=22 /usr/share/fonts/truetype/Roboto-Medium.ttf


sudo grub-mkfont --output=/boot/grub/fonts/semibold22.pf2 --size=22 /home/luck/字体/源云明体GenWanMinTW-SemiBold.ttf

表示使用 grub2-mkfont 来将 TrueType 字体 /usr/share/fonts/truetype/Roboto-Medium.ttf 转换为可以在 GRUB 中使用的字体，命名为 robotomedium.pf2，选择的字号为 22，并存放在 /boot/grub/fonts/ 文件夹下。

然后在 /etc/default/grub 中修改或增加下面一行，

GRUB_FONT=/boot/grub/fonts/robotomedium.pf2
GRUB_FONT=/boot/grub/fonts/semibold22.pf2
然后应用该配置，   sudo update-grub
 
再次启动的时候就能看到效果了。