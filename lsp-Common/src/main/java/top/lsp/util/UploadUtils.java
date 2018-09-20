package top.lsp.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.aliyun.oss.OSSClient;

public class UploadUtils {

    private static final Logger logger = LogManager.getLogger(UploadUtils.class);

    //获得文件扩展名，返回值包括点 .
    public static String getExtension(String filename) {
        return filename.substring(filename.lastIndexOf('.'), filename.length());
    }
    
    public static void uploadWithAliYun(String endpoint,String accessKeyId,String accessKeySecret,String bucketName,String objectName,File file) {

    	// 创建OSSClient实例。
    	OSSClient ossClient = new OSSClient(endpoint, accessKeyId, accessKeySecret);
    	// 上传文件。
		try {
			InputStream inputStream = new FileInputStream(file);
			ossClient.putObject(bucketName, objectName, inputStream);
			logger.debug("使用阿里云上传文件成功，文件名：{}", objectName);
		} catch (FileNotFoundException e) {
				logger.debug("使用阿里云上传文件抛出异常，文件名：{}", objectName, e);
				throw new RuntimeException("使用阿里云云上传文件抛出异常，文件名：" + objectName, e);
		}
    	// 关闭OSSClient。
    	ossClient.shutdown();
    }

}
