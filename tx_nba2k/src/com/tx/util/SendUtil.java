package com.tx.util;

import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.UnknownHostException;
import java.util.List;

import com.tx.pojo.Player;

public class SendUtil {
	public static void send(Object obj) throws UnknownHostException, IOException{
		//建立客户端Socket连接，指定服务器的位置及端口
		Socket socket = new Socket(GetIPUtil.getIP(),8800);
		//打开输入输出流
		OutputStream os = socket.getOutputStream();
		InputStream is = socket.getInputStream();
		//序列化
		ObjectOutputStream oos=  new ObjectOutputStream(os);
		//发送信息给服务端
		oos.writeObject(obj);
		socket.shutdownOutput();
	}
	
	public static Object reivece(byte[] by) throws UnknownHostException, IOException, ClassNotFoundException{
		//建立一个服务器Socket(ServerSocket)指定端口并开始监听
		ServerSocket ss = new ServerSocket(8800);
		//使用accpet()方法等待客户端触发通信
		Socket socket = ss.accept();
		//打开输入输出流
		InputStream is = socket.getInputStream();
		OutputStream os = socket.getOutputStream();
		//反序列化
		ObjectInputStream ois = new ObjectInputStream(is);
		//获取客户端信息，即从输入流读取信息
		List<Player> ps = (List<Player>)ois.readObject();
		if(ps!=null){
			
		}
		return null;
	}
	
}
