package com.cg.assetmanagement.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.persistence.RollbackException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionSystemException;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.cg.assetmanagement.dto.Allocation;
import com.cg.assetmanagement.dto.Asset;
import com.cg.assetmanagement.dto.Employee;
import com.cg.assetmanagement.dto.Request;
import com.cg.assetmanagement.dto.User;
import com.cg.assetmanagement.exception.AssetException;
import com.cg.assetmanagement.service.IAssetManagementService;

@Controller
@SessionAttributes(value = "user")
public class AppController {

	@Autowired
	IAssetManagementService service;

	@RequestMapping("/prepareLogin")
	public String prepareLogin(@ModelAttribute("loginDetails") User user,
			HttpSession session, Model model) {
		session.setMaxInactiveInterval(100);
		String loginName = (String) session.getAttribute("loginFail");
		model.addAttribute("loginFail", loginName);
		return "login";
	}

	@RequestMapping(value = "/LoginCheck", method = RequestMethod.POST)
	public ModelAndView validateUser(@ModelAttribute("loginDetails") User user,
			Model model, HttpSession session) {
		User user1 = null;
		try {
			user1 = service.validateUser(user);
		} catch (AssetException e) {
			model.addAttribute("loginFailure", 1);
			return new ModelAndView("Home", "user", new User());
		}
		if ("ADM".equals(user1.getUserType())) {
			return new ModelAndView("AdminHome", "user", user1);
		} else {
			if ("MGR".equals(user1.getUserType())) {
				return new ModelAndView("framed", "user", user1);
			}
		}
		model.addAttribute("loginFailure", 1);
		return new ModelAndView("Home", "user", new User());
	}

	@RequestMapping("/prepareAddAsset")
	public String prepareNewAsset(@ModelAttribute("addAsset") Asset asset,
			Map<String, Object> model) {
		List<String> assetTypeList = new ArrayList<String>();
		assetTypeList.add("IT");
		assetTypeList.add("NonIT");
		model.put("assetTypeList", assetTypeList);
		return "add_asset";
	}

	@RequestMapping("/Logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "Home";
	}

	@RequestMapping(value = "/AddNewAsset", method = RequestMethod.POST)
	public String addNewAsset(@ModelAttribute("addAsset") @Valid Asset asset,
			BindingResult result, Model model) {
		if (result.hasErrors()) {
			model.addAttribute("addAsset", asset);
			return "add_asset";
		} else {
			Integer assetId=null;
			try {
				assetId = service.addAsset(asset);
			} catch (AssetException| RollbackException
					| TransactionSystemException e) {
				model.addAttribute("assetId",-1);
				model.addAttribute("addAsset", new Asset());
				return "add_asset";
			}
			model.addAttribute("assetId", assetId);
			model.addAttribute("addAsset", new Asset());
		}
		return "add_asset";
	}

	@RequestMapping(value = "/goToModifyPage")
	public String goToModifyPage(Model model) {
		List<Asset> assetList = service.getAllAssets();
		model.addAttribute("assetList", assetList);
		model.addAttribute("modAsset", new Asset());
		return "modify_asset";
	}

	@RequestMapping(value = "/modifyAsset")
	public String modifyAsset(@ModelAttribute("modAsset") @Valid Asset asset,
			BindingResult result, Model model) {
		if (result.hasErrors()) {
			model.addAttribute("updateStatus", 2);
			List<Asset> assetList = service.getAllAssets();
			model.addAttribute("assetList", assetList);
			model.addAttribute("modAsset", asset);
			return "modify_asset";
		}
		try {
			service.updateAsset(asset);
		} catch (AssetException | RollbackException
				| TransactionSystemException e) {
			model.addAttribute("updateStatus", -1);
			List<Asset> assetList = service.getAllAssets();
			model.addAttribute("assetList", assetList);
			model.addAttribute("modAsset", asset);
			model.addAttribute("failureMessage", e.getMessage());
			return "modify_asset";
		}
		model.addAttribute("updateStatus", 1);
		List<Asset> assetList = service.getAllAssets();
		model.addAttribute("assetList", assetList);
		model.addAttribute("modAsset", new Asset());
		return "modify_asset";
	}

	@RequestMapping(value = "/goToDeletePage")
	public String goToDeletePage(Model model) {
		List<Asset> assetList = service.getAllAssets();
		model.addAttribute("assetList", assetList);
		return "delete";
	}

	@RequestMapping(value = "/DeleteAsset")
	public String modifyAsset(@RequestParam("assetId") Integer assetId,
			Model model) {
		try {
			service.delAssetById(assetId);
		} catch (AssetException | RollbackException
				| TransactionSystemException e) {
			List<Asset> assetList = service.getAllAssets();
			model.addAttribute("assetList", assetList);
			model.addAttribute("failureMessage", e.getMessage());
			return "delete";
		}
		List<Asset> assetList = service.getAllAssets();
		model.addAttribute("assetList", assetList);
		return "delete";
	}

	@RequestMapping(value = "/goToRequestForm")
	public String goToRequestForm(Model model, HttpSession session) {
		Integer mgrCode = ((User) (session.getAttribute("user"))).getEmployee()
				.getEmpNo();
		List<Asset> assetList = service.viewUnallocated();
		model.addAttribute("assetList", assetList);
		List<Employee> empList = service.getEmployeeUnderManager(mgrCode);
		model.addAttribute("empList", empList);
		return "assetRequest";
	}

	@RequestMapping(value = "/raiseRequest", method = RequestMethod.POST)
	public String raiseRequest(@RequestParam("assetId") String assetId,
			@RequestParam("employeeId") String employeeId,
			@RequestParam("requirement") String requirement, Model model,
			HttpSession session) {
		Request request = new Request();
		Integer requestId = null;
		Integer mgrCode = ((User) (session.getAttribute("user"))).getEmployee()
				.getEmpNo();
		try {
			request.setAsset(service.getAssetById(Integer.parseInt((assetId
					.split("<assetDescription>"))[0])));
			request.setEmployee(service.getEmployeeById(Integer
					.parseInt(employeeId)));
			request.setManager(service.getEmployeeById(mgrCode));
			request.setRequirement(requirement);
			request.setStatus("Pending");
			requestId = service.raiseRequest(request);
		} catch (AssetException | RollbackException
				| TransactionSystemException e) {
			List<Asset> assetList = service.viewUnallocated();
			model.addAttribute("assetList", assetList);
			List<Employee> empList = service.getEmployeeUnderManager(mgrCode);
			model.addAttribute("empList", empList);
			model.addAttribute("requestFail", 1);
			return "assetRequest";
		}
		model.addAttribute("requestId", requestId);
		List<Asset> assetList = service.viewUnallocated();
		model.addAttribute("assetList", assetList);
		List<Employee> empList = service.getEmployeeUnderManager(mgrCode);
		model.addAttribute("empList", empList);
		return "assetRequest";
	}

	@RequestMapping(value = "/getStatus")
	public String viewStatus(Model model, HttpSession session) {
		Integer mgrCode = ((User) (session.getAttribute("user"))).getEmployee()
				.getEmpNo();
		// List<Asset> assetList = service.getAllAssets();
		// model.addAttribute("assetList", assetList);
		List<Request> reqList = service.viewStatus(mgrCode);
		model.addAttribute("reqList", reqList);
		return "viewStatus";
	}

	@RequestMapping(value = "/RaisedRequests")
	public String getRaisedRequests(Model model) {
		List<Request> requestList = service.viewRequests();
		model.addAttribute("requestList", requestList);
		return "viewRequests";
	}

	@RequestMapping(value = "/ViewAsset")
	public String viewAsset(@RequestParam("id") String id, Model model) {
		Asset asset = null;
		try {
			asset = service.getAssetById(Integer.parseInt(id));
		} catch (NumberFormatException | AssetException e) {
			e.printStackTrace();
		}
		List<Request> requestList = service.viewRequests();
		model.addAttribute("requestList", requestList);
		model.addAttribute("asset", asset);
		return "viewRequests";
	}

	@RequestMapping(value = "/ViewEmployee")
	public String viewEmployee(@RequestParam("id") String id, Model model) {
		Employee employee = null;
		employee = service.getEmployeeById(Integer.parseInt(id));
		model.addAttribute("employee", employee);
		List<Request> requestList = service.viewRequests();
		model.addAttribute("requestList", requestList);
		return "viewRequests";
	}

	@RequestMapping(value = "/ViewAdmin")
	public String viewAdmin(@RequestParam("id") String id, Model model) {
		Employee admin = service.getAdminById(id);
		model.addAttribute("admin", admin);
		List<Request> requestList = service.viewRequests();
		model.addAttribute("requestList", requestList);
		return "viewRequests";
	}

	@RequestMapping(value = "/Accept")
	public String accept(@RequestParam("id") String id, Model model,
			HttpSession session) {
		Request request = service.getRequestById(Integer.parseInt(id));
		User user = (User) session.getAttribute("user");
		request.setUser(user);
		Integer allocationId = service.acceptRequest(request);
		List<Request> requestList = service.viewRequests();
		model.addAttribute("requestList", requestList);
		model.addAttribute("allocationId", allocationId);
		return "viewRequests";
	}

	@RequestMapping(value = "/Deny")
	public String denyRequest(@RequestParam("id") String id, Model model,
			HttpSession session) {
		User user = (User) session.getAttribute("user");
		Request request = service.getRequestById(Integer.parseInt(id));
		request.setUser(user);
		service.denyRequest(request);
		List<Request> requestList = service.viewRequests();
		model.addAttribute("requestList", requestList);
		return "viewRequests";
	}

	@RequestMapping(value = "/getUnallocated")
	public String getUnallocated(Model model) {
		List<Asset> unallocated = service.viewUnallocated();
		model.addAttribute("unallocated", unallocated);
		return "unallocated";
	}

	@RequestMapping(value = "/getAllocated")
	public String getAllocated(Model model) {
		List<Allocation> allocated = service.viewAllocated();
		model.addAttribute("allocated", allocated);
		return "allocated";
	}

	@RequestMapping(value = "/ShowAssetInAllocated")
	public String viewAssetInAllocated(@RequestParam("id") String id,
			Model model) {
		Asset asset = null;
		try {
			asset = service.getAssetById(Integer.parseInt(id));
		} catch (NumberFormatException | AssetException e) {
			e.printStackTrace();
		}
		List<Allocation> allocated = service.viewAllocated();
		model.addAttribute("allocated", allocated);
		model.addAttribute("asset", asset);
		return "allocated";
	}

	@RequestMapping(value = "/ShowEmployeeInAllocated")
	public String viewEmployeeInAllocated(@RequestParam("id") String id,
			Model model) {
		Employee employee = null;
		employee = service.getEmployeeById(Integer.parseInt(id));
		model.addAttribute("employee", employee);
		List<Allocation> allocated = service.viewAllocated();
		model.addAttribute("allocated", allocated);
		return "allocated";
	}

	@RequestMapping(value = "/ShowAssetInViewStatus")
	public String showAssetInViewStatus(@RequestParam("id") String id,
			Model model) {
		Asset asset = null;
		try {
			asset = service.getAssetById(Integer.parseInt(id));
		} catch (NumberFormatException | AssetException e) {
			e.printStackTrace();
		}
		List<Request> requestList = service.viewRequests();
		model.addAttribute("reqList", requestList);
		model.addAttribute("asset", asset);
		return "viewStatus";
	}

	@RequestMapping(value = "/ShowEmployeeInViewStatus")
	public String showEmployeeInViewStatus(@RequestParam("id") String id,
			Model model) {
		Employee employee = null;
		employee = service.getEmployeeById(Integer.parseInt(id));
		model.addAttribute("employee", employee);
		List<Request> requestList = service.viewRequests();
		model.addAttribute("reqList", requestList);
		return "viewStatus";
	}

	@RequestMapping(value = "/GenerateAllocatedReport")
	public String generateAllocatedReport(HttpServletRequest request) {
		List<Allocation> allocated = service.viewAllocated();
		request.setAttribute("allocated", allocated);
		request.setAttribute("exportToExcel", "YES");
		return "allocated";
	}

	@RequestMapping(value = "/GenerateUnallocatedReport")
	public String generateUnAllocatedReport(HttpServletRequest request) {
		List<Asset> unallocated = service.viewUnallocated();
		request.setAttribute("unallocated", unallocated);
		request.setAttribute("exportToExcel", "YES");
		return "unallocated";
	}

	@RequestMapping(value = "/GenerateRequestsReport")
	public String generateRequestsReport(HttpServletRequest request) {
		List<Request> requestList = service.viewRequests();
		request.setAttribute("requestList", requestList);
		request.setAttribute("exportToExcel", "YES");
		return "viewRequests";
	}

	@RequestMapping(value = "/GenerateStatusReport")
	public String generateStatusReport(HttpServletRequest request) {
		List<Request> requestList = service.viewRequests();
		request.setAttribute("reqList", requestList);
		request.setAttribute("exportToExcel", "YES");
		return "viewStatus";
	}
}
