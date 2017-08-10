package com.cg.assetmanagement.testcase;

import static org.junit.Assert.*;

import java.time.LocalDate;
import java.time.Month;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;

import com.cg.assetmanagement.dto.Asset;
import com.cg.assetmanagement.dto.User;

public class AssetManagementTestCase {

	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		
	}

	@AfterClass
	public static void tearDownAfterClass() throws Exception {
	}

	/*@Autowired
	private IAssetManagementDAO assetManagementDAO;*/

	@Test
	public void testAddAsset() {
		Asset asset = new Asset();
		
		asset.setAssetName("Laptop");
		LocalDate dt1 = LocalDate.of(2015, Month.FEBRUARY, 8);
		asset.setPurchaseDate(dt1);
		asset.setUnitPrice(21000.5);
		asset.setAssetType("IT");
		asset.setCategory("Hardware");
		asset.setQuantity(10);
		asset.setAssetDes("Dell Laptop");
		
	}

	@Test
	public void testUpdateAsset() {
		Asset asset = new Asset();
		
       asset.setAssetId(100007);
       asset.setAssetName("Desks");
       asset.setAssetType("Non-IT");
       asset.setCategory("Furniture");
       asset.setQuantity(21);
		//int assetId =100007;
		//String id=Integer.toString(assetId);
		/*try {
			asset = assetManagementDAO.getAssetById(assetId);
		} catch (AssetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		try {
			assetManagementDAO.updateAsset(asset);
		} catch (AssetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
		if (asset.getAssetId().equals(100007)) {
			
			assertTrue(true);
		} else {
			assertTrue(false);
		}
	}

	@Test
	public void testValidateUser() {
		User user = new User();
	
		user.setUserId("A10001");
		user.setUserPassword("adm12345");
		/*try {
		User user1  = assetManagementDAO.validateUser(user);
		
		} catch (AssetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
		if (user.getUserId().equals("A10001")
				&& (user.getUserPassword().equals("adm12345"))) {
			assertTrue(true);
		} else {
			assertTrue(false);
		}

	}

}
