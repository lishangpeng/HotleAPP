package top.lspa.service;

import org.springframework.stereotype.Service;

import top.lspa.pojo.Room;
import top.lspa.pojo.RoomUser;
import top.lspa.pojo.User;

@Service
public class RoomUserService extends ManyToManyBaseService<RoomUser, Room, User>{

}
