package com.sp.app.daily;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.common.FileManager;
import com.sp.app.common.dao.CommonDAO;
@Service("daily.dailyService")
public class DailyServiceImpl implements DailyService{
	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
	@Override
	public void insertDaily(Daily dto, String pathname) throws Exception {
		try {
			int seq = dao.selectOne("daily.seq");			
			
			dto.setDailyNum(seq);
			dao.insertData("daily.insertDaily",dto);
			
			// 파일 업로드
			if(! dto.getUpload().isEmpty()) {
				for(MultipartFile mf:dto.getUpload()) {
					String imageFilename=fileManager.doFileUpload(mf, pathname);
					if(imageFilename==null) continue;	
					dto.setImageFilename(imageFilename);
					int image_seq = dao.selectOne("daily.image_seq");
					dto.setDaily_imageFilenum(image_seq);		
					insertFile(dto);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0 ;
		
		try {
			result = dao.selectOne("daily.dailyCount",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Daily> listDaily(Map<String, Object> map) {
		List<Daily> list = null;
		try {
			list = dao.selectList("daily.listDaily",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Daily> listDailyTop() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Daily readDaily(int dailyNum) throws Exception {
		Daily dto = null;
		try {
			dto = dao.selectOne("daily.readDaily",dailyNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public List<Daily> readDailyFile(int dailyNum) throws Exception {
		List<Daily> list1 = null;
		try {
			list1 = dao.selectList("daily.listArticleFile",dailyNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list1;
	}
	
	@Override
	public List<Daily> listFile(int dailyNum) {
		List<Daily> listFile = null;
		try {
			listFile = dao.selectList("daily.listFile",dailyNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listFile;
	}
	
	
	@Override
	public void updateDaily(Daily dto, String pathname) throws Exception {
		try {
			int seq = dto.getDailyNum();			
			
			dto.setDailyNum(seq);
			dao.updateData("daily.updateDaily", dto);
			
			// 파일 업로드
			if(! dto.getUpload().isEmpty()) {
				for(MultipartFile mf:dto.getUpload()) {
					String imageFilename=fileManager.doFileUpload(mf, pathname);
					if(imageFilename==null) continue;	
					dto.setImageFilename(imageFilename);
					int image_seq = dao.selectOne("daily.image_seq");
					dto.setDaily_imageFilenum(image_seq);		
					insertFile(dto);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public void deleteDaily(int dailyNum, String pathname) throws Exception {
		try {
			
			List<Daily> listFile=listFile(dailyNum);
			if(listFile!=null) {
				for(Daily dto:listFile) {
					fileManager.doFileDelete(dto.getImageFilename(), pathname);
				}
			}
			
			
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("field", "dailyNum");
			map.put("dailyNum", dailyNum);
			deleteFileAll(map);
			
			
			dao.deleteData("daily.deleteDaily", dailyNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void insertFile(Daily dto) throws Exception {
		try {
			dao.insertData("daily.insertFile", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	

	@Override
	public Daily readFile(int fileNum) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteFile(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("daily.deleteFile", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}		
	}
	
	@Override
	public void deleteFileAll(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("daily.deleteFileAll", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}		
		
	}


	@Override
	public void updateHitCount(int num) throws Exception {
		try {
			dao.updateData("daily.updateHitCount", num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public Daily preReadDaily(Map<String, Object> map) {
		Daily dto=null;

		try {
			dto=dao.selectOne("daily.preReadDaily", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
		
	}

	@Override
	public Daily nextReadDaily(Map<String, Object> map) {
		Daily dto=null;

		try {
			dto=dao.selectOne("daily.nextReadDaily", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
		
	}

	@Override
	public void insertDailyLike(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("daily.insertDailyLike", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public int dailyLikeCount(int dailyNum) {
		int result=0;
		try {
			result=dao.selectOne("daily.dailyLikeCount", dailyNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	

	@Override
	public void insertReply(Reply dto) throws Exception {
		try {
			dao.insertData("daily.insertReply", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Reply> listReply(Map<String, Object> map) {
		List<Reply> list=null;
		try {
			list=dao.selectList("daily.listReply", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int replyCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("daily.replyCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void deleteReply(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("daily.deleteReply", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Reply> listReplyAnswer(int answer) {
		List<Reply> list=null;
		try {
			list=dao.selectList("daily.listReplyAnswer", answer);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int replyAnswerCount(int answer) {
		int result=0;
		try {
			result=dao.selectOne("daily.replyAnswerCount", answer);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void insertReplyLike(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("daily.insertReplyLike", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public Map<String, Object> replyLikeCount(Map<String, Object> map) {
		Map<String, Object> countMap=null;
		try {
			countMap=dao.selectOne("daily.replyLikeCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return countMap;
	}

	


	



	
}
