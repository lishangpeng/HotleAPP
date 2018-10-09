package top.lapa.web.pay;

public class AlipayConfig {
	// 商户appid
	public static String APPID = "2016092100565795";
	// 私钥 pkcs8格式的
	public static String RSA_PRIVATE_KEY = "MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCN2F1H/U2WvtKrV65cjcLGRs0kk7TUczNekZmoF7t1ro6LjQWnkRt30D7deiTAdLWWcCDha/TCzldZsak56hsS2K41v1ZrVwizQwfQz4s5Xg2nGN2jmJm0KqxkptA/JKJg9oRH8lvhUj+eis3MQmzmHJ1uqunXtBBNAa6hbE+CF/1YeMZOKSMEOOEIUuoyU36OkPh9gK04sbraEVReazF7j0NNXdB/QPTVciA+3yB1fyA32izpUCFW9BC0F6nvdx0GoXgKC55NK+b/9Ns1GV8ctke/nKhcExOKRDHaWmUJfTMvzVuo7Vkw16ZOqL+bPn50mTIzcoYyE26rFNpFtNKBAgMBAAECggEAK7PeCbAhl7BzeBcrwZhrymtGCV749/wGd7ykewXU3A1MHfL1KwuqSt/+fn6DlEhhKlihyNJaNysb/qaeXRmj/cqE4kpxdeD67UBZyBwp6SLxUep3X1BFCx2av+glgU7oOLe7Se+CH4oXz+E0RxqwMrXeS5qdMbhozVEXXOTiGlKSCOlXwghDcRU51xKDe9HDjaBlTR9UE9Yd6pnD5fJiRe8vmlULy5YdqPGgGEBD6ZHkPyNtb9SoMGyPgV1U3G16Cp0TUm6C0r55lyPgM2deIxyr6WMWPsYAJaPHhPWnG2iQCIv/E0kKN++Pe172G/qQlNYW+EK2Bsik1nWdLNbRgQKBgQDpL11wB0QV+bOJkVvQZswF/Mpz4JtXw3BBXr2P98QW9HnsFK9TTrYoxCRQ91xJvd/44QaYvUGQlZS0XBGV4wxsFnogmIu08zz5vCJ0T30bSqlrufakLoGMYSO2U8KU4TN4wWdGbeoyVwt+P7QemnUCOHnabjbVfBguvjhb9MgpEwKBgQCbuTDUtnahNTZ/EWHeyTs00ws/eLq4NQZsFZnFN072HJE2pPIqAxQ2x61xB8+Qz7AEo2hQLNd9n2+W/psYlyNoasoOOEWgTvZ6lP67zMQ1FQ6ykDWkAJUxaMXX6m6vFDW0IPWbH1JLwfCTboTWnsz6NsOA+G6gxJqLZdTxGX68mwKBgAb4Ynuhy/g4MZSwIqV1HS4ko0yZbytNbUKW+WWfS15ASpCzAZak6K8JReihrEGMCnDfERpptdcDkaFeiywG0G0+ssHcrXhoOO9iH0mIwr2ZGr1cnrHDrh2rHa0qjctze91lMpgZWwHMNky8zL6JcWvykjnkR4FUJ0jmaLre80i/AoGBAI/azk9Sl9hojgVoi18Byp4L8DIcV3FgGqSyd7EGXP1ieoteaQ+CdKP+Zi0qqAcAtXwzcGPQaOl15eI5JhHbXSxSqoHkXf2vtGadSY03pnHbGA7AxazRlQFl5o6F1OYL52iVog5BKwctDA9GY5TYckcbXBPCbIA73wCze7mWccvNAoGBAIjCChfZ9Pguj0UDTnhaOSxmr45NH6LyGOwzbIGoBZ1UHcBWu0w5gaiesJEnAptS87M08LrYiHkO21NwCZ6IuqvI8dtyQkCAETOqCWAmbZk6hdvQJyu/RA034lCqeCk6D2eQoHrwIU2KoFM9CWEWMXcW0tmXdLVWUhxH+noIfVvY";
	// 服务器异步通知页面路径 需http://或者https://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
	public static String notify_url = "http://47.106.248.112/lsp-Front/";
	// 页面跳转同步通知页面路径 需http://或者https://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问 商户可以自定义同步跳转地址
	public static String return_url = "http://47.106.248.112/lsp-Front/";
	// 请求网关地址
	public static String URL = "https://openapi.alipaydev.com/gateway.do";
	// 编码
	public static String CHARSET = "UTF-8";
	// 返回格式
	public static String FORMAT = "json";
	// 支付宝公钥
	public static String ALIPAY_PUBLIC_KEY = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAydQCZpVXQ0Zb0t6Iw/h/pnHLEd0GvOUoLW4HXrlHAan+0Y3LGqh2vBMx2cScqNo++DzKfJD/Q3XA/wy6dJ0ZW0Qio8PUpT+mt0Zoip9MiANZuxRzr/zLhdZvrdt7SeWFI8SVaPvrf44L5LsxmN6icTZWNrA+qJvn8f3+Lsg1o3Pt6PJWOBWWd99gi/zCFRGHYJ6IU5g/7EwhbcUWtKPpRXV9KFQUM3XZe3ZFSlEn2d1jNV0c2A8zwSwISlTQSYDmIiOez2ayL5fEq2BPs7eaSHZiY51hzLDIWSuKthizyF0UcsWG0TNHGpWSHF8hZBEBTPoGO9+2YTuVMcIaE7ayPQIDAQAB";
	// 日志记录目录
	public static String log_path = "/log";
	// RSA2
	public static String SIGNTYPE = "RSA2";
}
