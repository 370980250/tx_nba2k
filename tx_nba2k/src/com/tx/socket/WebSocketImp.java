package com.tx.socket;

import java.io.IOException;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;
import java.util.concurrent.atomic.AtomicInteger;

import javax.servlet.http.HttpSession;
import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;



@ServerEndpoint(value = "/push", configurator = GetHttpSessionConfigurator.class)
public class WebSocketImp {
	private static final String GUEST_PREFIX = "Guest";  
	private static final AtomicInteger connectionIds = new AtomicInteger(0);  
	private static final Set<WebSocketImp> connections = new CopyOnWriteArraySet<>();  
	private Session session;	
	private final String nickname;  
	private static HttpSession httpSession;  
	public WebSocketImp(){
		nickname = GUEST_PREFIX + connectionIds.getAndIncrement();  
	}
	@OnOpen
	public void onOpen(EndpointConfig config,Session session){
		this.session = session;
		System.out.println("WebSocket建立");
	    httpSession = (HttpSession) config.getUserProperties().get(  
                HttpSession.class.getName()); 
	    connections.add(this);  
	    System.out.println(httpSession.getAttribute("tempId"));
		
	}
	
	@OnMessage
	public void onMessage(String message){
		
		broadcast(message);  
	}
	@OnClose
	public void onClose(){
		connections.remove(this);  
        String message = String.format("* %s %s", nickname, "has disconnected.");  
        broadcast(message);  
	}
	
	
	@OnError  
    public void onError(Throwable t) throws Throwable {  
        System.out.println(" Error: " + t.toString());  
    }  
	
	private static void broadcast(String msg) {  
        for (WebSocketImp client : connections) {  
            try {  
                synchronized (client) {  
                    client.session.getBasicRemote().sendText(msg);  
                }  
            } catch (IOException e) {  
                System.out.println("Chat Error: Failed to send message to client");  
                connections.remove(client);  
                try {  
                    client.session.close();  
                } catch (IOException e1) {  
                }  
                String message = String.format("* %s %s", client.nickname,  
                        "has been disconnected.");  
                broadcast(message);  
            }  
        }  
    }  
	

	
	
}
