package com.tx.util;

import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.List;

import com.tx.pojo.Player;

public class Server {
	public Server() throws IOException, ClassNotFoundException{
		//建立一个Socket指定端口并开始监听
		ServerSocket serverSocket  = new ServerSocket(8800);
		while(true){
			//使用accpet()方法等待客户端触发通信
			Socket socket = serverSocket.accept();
			//打开输入输出流
			OutputStream os = socket.getOutputStream();
			InputStream is = socket.getInputStream();
			//反序列化
			ObjectInputStream ois = new ObjectInputStream(is);
			//获取客户端信息，即从输入流读取信息
			List<Player> ps = (List<Player>)ois.readObject();
			if(ps!=null){
				ObjectOutputStream oos = new ObjectOutputStream(socket.getOutputStream());
				oos.writeObject(ps);
				oos.flush();
				oos.close();
				is.close();
				os.close();
			}
		}
		
	}
}
