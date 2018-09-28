package top.lspa.mapper;

import top.lspa.pojo.Room;
import top.lspa.pojo.RoomUser;
import top.lspa.pojo.User;

public interface RoomUserMapper extends IManyToManyMapper<RoomUser, Room, User>{

}
