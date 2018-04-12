package edu.iot.butter.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import edu.iot.butter.model.Sensor;
import edu.iot.butter.service.SensorService;

@RestController	//view가 아닌 메서드의 response body로 해석
@RequestMapping("/api/sensor")
public class SensorApiController {
	
	@Autowired
	SensorService service;
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	public List<Sensor> getList() {
		return service.getList();
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public Sensor get(@PathVariable long id) {
		return service.get(id);
	}

	@RequestMapping(value = "/", method = RequestMethod.POST)
	public boolean insert(@RequestBody Sensor sensor) { 
		// @RequestBody는 JSON 인코딩 방식으로 해석한다.(생략시 url인코딩으로) 
		return service.insert(sensor);
	}

	@RequestMapping(value = "/", method = RequestMethod.PUT)
	public boolean update(@RequestBody Sensor sensor) {
		return service.update(sensor);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	public boolean delete(@PathVariable long id) {
		return service.delete(id);
	}
	
}
