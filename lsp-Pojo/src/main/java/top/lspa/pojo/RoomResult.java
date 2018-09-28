package top.lspa.pojo;

public class RoomResult {
	private Long roomId;
	private boolean havePeople;//懒得改了 其实是noHavePeople因为用is EL表达式会出问题
	public Long getRoomId() {
		return roomId;
	}
	public void setRoomId(Long roomId) {
		this.roomId = roomId;
	}
	public boolean isHavePeople() {
		return havePeople;
	}
	public void setHavePeople(boolean havePeople) {
		this.havePeople = havePeople;
	}

}
