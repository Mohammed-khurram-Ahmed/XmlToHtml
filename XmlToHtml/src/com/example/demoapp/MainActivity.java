package com.example.demoapp;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.StringWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.TransformerFactoryConfigurationError;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Context;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.webkit.JavascriptInterface;
import android.webkit.WebView;
import android.widget.Button;

public class MainActivity extends Activity {

	final Handler myHandler = new Handler();
	private WebView webview;
	private ArrayList<String> arrayListValue;
	

	@SuppressLint("JavascriptInterface")
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		getWindow().requestFeature(Window.FEATURE_PROGRESS);

		setContentView(R.layout.activity_main);

		webview = (WebView) findViewById(R.id.webview);

		Button button = (Button) findViewById(R.id.button);

		arrayListValue=new ArrayList<String>();
		
		button.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				getFilledData();
				
			}

		});
		
		
		Button buttonShowdata = (Button) findViewById(R.id.button1);

		buttonShowdata.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				
				Log.e("hittestresult",""+webview.getHitTestResult().toString());
				Log.e("hittestresult",""+webview.getHitTestResult().getType());
				Log.e("hittestresult",""+webview.getHitTestResult().getExtra());
				
				for(int i=0;i<arrayListValue.size();i++){
					Log.e("value",""+arrayListValue.get(i));
				}
			}

		});

		webview.getSettings().setJavaScriptEnabled(true);

		// Reading XSLT
//*		String strXSLT = GetStyleSheet(R.raw.samplebixsl);
		// Reading XML
//*		String strXML = GetStyleSheet(R.raw.samplebi);
		
		String URL = "http://api.androidhive.info/pizza/?format=xml";
		AsyncTaskXML asyncTaskXml=new AsyncTaskXML();
		asyncTaskXml.execute(URL);
	
		
		// get Html
//*		String html = StaticTransform(strXSLT, strXML);

		// set javascript enabled
		webview.getSettings().setJavaScriptEnabled(true);
		
	/*	webview.setWebViewClient(new WebViewClient(){
			@Override
			public void onPageFinished(WebView view, String url) {
				super.onPageFinished(view, url);
				Log.e("on page finished","on page finished");
				
				 webview.loadUrl("javascript:(function() { " +  
			                "document.getElementsByTagName('body')[0].style.color = 'blue'; " +  
			                "})()");  
			
			}
		});*/

		// Loading the above transformed CSLT in to Webview
//*		webview.loadData(html, "text/html", null);
	

		// create interface
		webview.addJavascriptInterface(new WebAppInterface(this), "Android");

	}

	// Transform XSLT to HTML string

	public static String StaticTransform(String strXsl, String strXml) {
		String html = "";

		try {

			InputStream ds = null;
			ds = new ByteArrayInputStream(strXml.getBytes("UTF-8"));

			Source xmlSource = new StreamSource(ds);

			InputStream xs = new ByteArrayInputStream(strXsl.getBytes("UTF-8"));
			Source xsltSource = new StreamSource(xs);
			StringWriter writer = new StringWriter();
			Result result = new StreamResult(writer);
			TransformerFactory tFactory = TransformerFactory.newInstance();
			Transformer transformer = tFactory.newTransformer(xsltSource);
			transformer.transform(xmlSource, result);

			html = writer.toString();

			ds.close();
			xs.close();

			xmlSource = null;
			xsltSource = null;

		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (TransformerConfigurationException e) {
			e.printStackTrace();
		} catch (TransformerFactoryConfigurationError e) {
			e.printStackTrace();
		} catch (TransformerException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return html;
	}

	// Read file from res/raw...

	private String GetStyleSheet(int fileId) {
		String strXsl = null;

		InputStream raw = getResources().openRawResource(fileId);
		ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
		int size = 0;
		// Read the entire resource into a local byte buffer.
		byte[] buffer = new byte[1024];
		try {
			while ((size = raw.read(buffer, 0, 1024)) >= 0) {
				outputStream.write(buffer, 0, size);
			}
			raw.close();

			strXsl = outputStream.toString();

		} catch (IOException e) {
			e.printStackTrace();
		}

		return strXsl;

	}
	

	public class WebAppInterface {
		Context mContext;

		/** Instantiate the interface and set the context */
		WebAppInterface(Context c) {
			mContext = c;
		}

		// display value

		@JavascriptInterface
		public void displayValue(String value) {
			arrayListValue.add(value);
		}

	}

	private void getFilledData() {

		webview.loadUrl("javascript:Android.displayValue(document.getElementById('column2').value)");

		webview.loadUrl("javascript:Android.displayValue(document.getElementById('column3').value)");

		webview.loadUrl("javascript:Android.displayValue(document.getElementById('column4').value)");

		webview.loadUrl("javascript:var listG=document.getElementsByName('gender1');Android.displayValue(listG[0].checked)");

		webview.loadUrl("javascript:var listG=document.getElementsByName('gender1');Android.displayValue(listG[1].checked)");

		webview.loadUrl("javascript:Android.displayValue(document.getElementById('column8').value)");

		webview.loadUrl("javascript:Android.displayValue(document.getElementById('column12').value)");

		webview.loadUrl("javascript:Android.displayValue(document.getElementById('column14').value)");

		webview.loadUrl("javascript:Android.displayValue(document.getElementById('column15').checked)");

		webview.loadUrl("javascript:Android.displayValue(document.getElementById('column16').value)");

		webview.loadUrl("javascript:Android.displayValue(document.getElementById('column17').value)");

		webview.loadUrl("javascript:Android.displayValue(document.getElementById('column18').value)");

		webview.loadUrl("javascript:var listG=document.getElementsByName('gender2');Android.displayValue(listG[0].checked)");

		webview.loadUrl("javascript:var listG=document.getElementsByName('gender2');Android.displayValue(listG[1].checked)");

		webview.loadUrl("javascript:Android.displayValue(document.getElementById('column22').value)");

		webview.loadUrl("javascript:Android.displayValue(document.getElementById('column26').value)");

		webview.loadUrl("javascript:Android.displayValue(document.getElementById('column28').value)");

	}
	
	class AsyncTaskXML extends AsyncTask<String, Void, String>{

		@Override
		protected String doInBackground(String... url) {
			
			String strXSLT = GetStyleSheet(R.raw.samplebixsl);
			
			String strXML = GetStyleSheet(R.raw.samplebi);
			
			XMLParser parser = new XMLParser();
			
			String myXml = parser.getXmlFromUrl(url[0]); // getting XML
			
			Log.e("xml",""+myXml);
			 
		//	String html = StaticTransform(strXSLT, myXml); 
			
			String html = StaticTransform(strXSLT, strXML);
			
			return html;
		}
		
		@Override
		protected void onPostExecute(String result) {
			super.onPostExecute(result);
			webview.loadData(result, "text/html", null);
		}
		
	}
	
	
	
}
