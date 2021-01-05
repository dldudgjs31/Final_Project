package com.sp.app.admin.storebanner;

import java.util.List;

public interface StoreBannerService {
	public void insertImage(StoreBanner dto, String pathname)throws Exception;
	public List<StoreBanner> listFile();
	public void updateImage(StoreBanner dto, String pathname) throws Exception;
	public void deleteImage(int fileNum) throws Exception;
	public void deleteAll() throws Exception;
}
