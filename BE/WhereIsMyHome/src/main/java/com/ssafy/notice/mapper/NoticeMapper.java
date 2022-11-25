package com.ssafy.notice.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ssafy.notice.model.NoticeDTO;

public interface NoticeMapper {
	int writeArticle(NoticeDTO noticeDTO) throws SQLException;
	List<NoticeDTO> listArticle() throws SQLException;
	NoticeDTO getArticle(int articleNo) throws SQLException;
	int modifyArticle(NoticeDTO noticeDTO) throws SQLException;
	int deleteArticle(int articleNo) throws SQLException;
	int updateHit(int articleNo) throws SQLException;
}
