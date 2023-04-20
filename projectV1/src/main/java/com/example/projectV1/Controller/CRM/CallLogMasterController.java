package com.example.projectV1.Controller.CRM;

import java.util.List;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.projectV1.Service.CRM.CallLogMasterService;

@RestController
@RequestMapping(path = "/crm/calls")
public class CallLogMasterController {
    private final CallLogMasterService callLogMasterService;

    public CallLogMasterController(CallLogMasterService callLogMasterService) {
        this.callLogMasterService = callLogMasterService;
    }

    // public List<CallLogMaster> getCallLogsByEnquiry()
    // {
    // return callLogMasterService.getCalls();
    // }

}
