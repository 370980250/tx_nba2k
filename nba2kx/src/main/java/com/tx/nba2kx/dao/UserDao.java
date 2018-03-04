package com.tx.nba2kx.dao;

import org.apache.ibatis.annotations.Insert;

public interface UserDao {
    @Insert("insert into tx_user ")
    int addUser();
}
