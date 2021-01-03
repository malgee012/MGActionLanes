#!/usr/bin/python
# -*- coding: UTF-8 -*-

 
import smtplib
from email.mime.text import MIMEText
from email.utils import  formataddr
 
import json
import sys
reload(sys)

sys.setdefaultencoding('utf-8')

# 第三方SMTP邮件服务
mail_sender='951684507@qq.com'    # 发件人邮箱账号
mail_auth_pass = 'ubbtqklyrscdbdhc'   # 发件人邮箱授权密码

my_user_1='3178769613@qq.com'      # 收件人邮箱账号，我这边发送给自己
my_user_2='malgee@163.com' 

# 邮件接收者
mail_receivers = ['3178769613@qq.com', 'malgee@163.com']
mail_to = ','.join(mail_receivers)

print(mail_to)

def mail():
    ret=True
    try:
        # MIMEText 构建邮件
        msg=MIMEText('修改了2个bug,优化了多个页面','plain','utf-8')
        msg['From']=formataddr(["maling",mail_sender])  # 括号里的对应发件人邮箱昵称、发件人邮箱账号
        # msg['To']=formataddr(["六六",my_user_1])              # 括号里的对应收件人邮箱昵称、收件人邮箱账号
        msg['To']=mail_to
        msg['Subject']="打包完成，请测试验证问题"                # 邮件的主题，也可以说是标题
 
        # smtplib 发送邮件
        server=smtplib.SMTP_SSL("smtp.qq.com", 465)  # 发件人邮箱中的SMTP服务器，端口是25
        server.login(mail_sender, mail_auth_pass)  # 括号中对应的是发件人邮箱账号、邮箱密码
        server.sendmail(mail_sender,mail_receivers,msg.as_string())  # 括号中对应的是发件人邮箱账号、收件人邮箱账号、发送邮件
        server.quit()  # 关闭连接
    except Exception:  # 如果 try 中的语句没有执行，则会执行下面的 ret=False
        ret=False
    return ret
 
ret=mail()
if ret:
    print("邮件发送成功")
else:
    print("邮件发送失败")
