package com.tx.pojo;

import org.springframework.stereotype.Component;

@Component
public class Query {
	public String qname;

	public String getQname() {
		return qname;
	}

	public void setQname(String qname) {
		this.qname = qname;
	}
	
}
