package com.aniwatch.api.provider;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/providers")
public class providerController {

    @Autowired
    private providerData data;

    /**
     * Get a list of all the providers in the database.
     * http://localhost:8080/providers/allProviders
     *
     * @return a list of providers.
     */
    @GetMapping("/allProviders")
    public Object getAllProviders() {
        return new ResponseEntity<>(data.getAllProviders(), HttpStatus.OK);
    }

    /**
     * Get a provider using their ID.
     * http://localhost:8080/providers/1
     *
     * @param providerId provider ID.
     * @return a provider object.
     */
    @GetMapping("/{providerId}")
    public Object getOneProvider(@PathVariable int providerId) {
        return new ResponseEntity<>(data.getProviderByProviderId(providerId), HttpStatus.OK);
    }

    /**
     * Get a list of the providers with a name that contains a given string.
     * http://localhost:8080/providers/name?search=Primordial
     *
     * @param search the search key
     * @return list of all providers matching the search key.
     */
    @GetMapping("/username")
    public Object getProviderByUsername(@RequestParam(name = "search", defaultValue = "") String search) {
        return new ResponseEntity<>(data.getProviderByUsername(search), HttpStatus.OK);
    }

    /**
     * Get a list of providers based on their bio.
     * http://localhost:8080/providers/bio/bio-info
     *
     * @param bio the search key.
     * @return A list of provider objects that match the search key.
     */
    @GetMapping("/bio/{bio}")
    public Object getProviderByBio(@PathVariable String bio) {
        return new ResponseEntity<>(data.getProviderByBio(bio), HttpStatus.OK);
    }

    /**
     * http://localhost:8080/providers/newProvider
     * { "username": "Primordial", "bio": "Testing put mapping", "password" : "primo" }
     *
     * @param provider the new provider
     * @return updated list of providers
     */
    @PostMapping("/newProvider")
    public Object addNewProvider(@RequestBody provider provider) {
        data.addNewProvider(provider);
        return new ResponseEntity<>(data.getAllProviders(), HttpStatus.CREATED);
    }

    /**
     * Update an existing providers data.
     * http://localhost:8080/providers/updateProvider/1
     * { "username": "Primordial", "bio": "Testing put mapping", "password" : "primo" }
     *
     * @param providerId the providers ID.
     * @param provider the new updated provider details.
     * @return the updated provider object.
     */
    @PutMapping("/updateProvider/{providerId}")
    public Object updateProvider(@PathVariable Integer providerId, @RequestBody provider provider) {
        data.updateProvider(providerId, provider);
        return new ResponseEntity<>(data.getProviderByProviderId(providerId), HttpStatus.CREATED);
    }

    /**
     * Delete a provider.
     * http://localhost:8080/providers/deleteProvider/1
     * { "username": "Primordial", "bio": "Testing put mapping", "password" : "primo" }
     *
     * @param providerId the providers ID.
     * @return the updated list of providers.
     */
    @DeleteMapping("/deleteProvider/{providerId}")
    public Object deleteProviderById(@PathVariable Integer providerId) {
        data.deleteProviderByProviderId(providerId);
        return new ResponseEntity<>(data.getAllProviders(), HttpStatus.OK);
    }
}
