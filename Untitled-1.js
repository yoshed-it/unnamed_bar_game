 $w.onReady(() => {
    console.log("Page is ready");

    // Load categories dynamically from JSON
    const categories = businessData.categories.map((category, index) => ({
        _id: `category${index + 1}`,
        name: category.name
    }));

    $w("#repeater1").data = categories;

    // Handle the first Repeater (categories)
    $w("#repeater1").onItemReady(($item, itemData) => {
        const locationNameText = $item("#locationNameText");

        if (locationNameText) {
            locationNameText.text = itemData.name;

            locationNameText.onClick(() => {
                $w('#mapImage').customClassList.add('opacity')
                console.log(`Category clicked: ${itemData.name}`);

                // Get unique cities for the selected category
                const category = businessData.categories.find(cat => cat.name === itemData.name);
                const cities = category.locations.map(location => location.location);
                const uniqueCities = [...new Set(cities)];

                // Populate the second Repeater with unique cities
                $w("#repeater2").data = uniqueCities.map((city, index) => ({
                    _id: `city${index + 1}`,
                    name: city
                }));

                // Show the second Repeater and switch to state2
                if (uniqueCities.length > 0) {
                    $w("#repeater2").show();
                    $w("#multiStateBox1").changeState("state2");
                } else {
                    console.log(`No cities found for ${itemData.name}.`);
                    $w("#repeater2").hide();
                }

                // Hide third and fourth Repeaters
                $w("#repeater3").hide();
                $w("#repeater4").hide();
            });
        } else {
            console.error("Element with ID '#locationNameText' does not exist.");
        }
    });

    // Handle the second Repeater (cities)
    $w("#repeater2").onItemReady(($item, itemData) => {
        const cityNameText = $item("#cityNameText");

        if (cityNameText) {
            cityNameText.text = itemData.name;

            cityNameText.onClick(() => {
                console.log(`City clicked: ${itemData.name}`);

                // Get businesses for the selected city
                const businesses = [];
                businessData.categories.forEach(category => {
                    category.locations.forEach(location => {
                        if (location.location === itemData.name) {
                            businesses.push({
                                _id: location.id,
                                name: location.name,
                                id: location.id
                            });
                        }
                    });
                });

                // Populate the third Repeater with businesses
                $w("#repeater3").data = businesses;

                // Show the third Repeater and switch to state3
                if (businesses.length > 0) {
                    $w("#repeater3").show();
                    $w("#multiStateBox1").changeState("state3");
                } else {
                    console.log(`No businesses found in ${itemData.name}.`);
                    $w("#repeater3").hide();
                }

                // Hide the fourth Repeater
                $w("#repeater4").hide();
            });
        } else {
            console.error("Element with ID '#cityNameText' does not exist.");
        }
    });

    // Handle the third Repeater (businesses)
    $w("#repeater3").onItemReady(($item, itemData) => {
        const businessNameText = $item("#businessNameText");

        if (businessNameText) {
            businessNameText.text = itemData.name;

            businessNameText.onClick(() => {
                console.log(`Business clicked: ${itemData.name}`);

                // Get business details based on the clicked business ID
                const selectedBusiness = getBusinessDetails(itemData.id);

                if (selectedBusiness) {
                  $w("#mapImage").scrollTo();
                    // Populate the fourth Repeater with business details
                    $w("#repeater4").data = [{
                        _id: `detail${selectedBusiness.id}`,
                        title: selectedBusiness.name,
                        website: selectedBusiness.website,
                        address: selectedBusiness.address,
                        phone: selectedBusiness.phone
                    }];

                    // Show the fourth Repeater and switch to state4
                    $w("#repeater4").show();
                    $w("#multiStateBox1").changeState("state4");
                } else {
                    console.error(`No business details found for ID ${itemData.id}.`);
                }
            });
        } else {
            console.error("Element with ID '#businessNameText' does not exist.");
        }
    });

    // Handle the fourth Repeater (business details)
    $w("#repeater4").onItemReady(($item, itemData) => {
        const businessTitleText = $item("#businessTitleText");
        const businessWebsiteText = $item("#businessWebsiteText");
        const businessAddressText = $item("#businessAddressText");
        const businessPhoneText = $item("#businessPhoneText");
        
        

        if (businessTitleText && businessWebsiteText && businessAddressText && businessPhoneText) {
            businessTitleText.text = itemData.title || 'No Title';
            businessWebsiteText.text = itemData.website || 'No Website';
            businessAddressText.text = itemData.address || 'No Address';
            businessPhoneText.text = itemData.phone || 'No Phone';
        } else {
            console.error("One or more elements in the fourth Repeater do not exist.");
        }

        if (businessWebsiteText) {
          businessWebsiteText.text = businessWebsiteText.text;  // Set the text to "Website"
          businessWebsiteText.onClick(() => {
          wixLocation.to(itemData.website);
          });
        }
    });

    // Initially hide the second, third, and fourth Repeaters until needed
    $w("#repeater2").hide();
    $w("#repeater3").hide();
    $w("#repeater4").hide();
});

// Helper function to get business details by ID
function getBusinessDetails(businessId) {
    let businessDetail;

    businessData.categories.forEach(category => {
        category.locations.forEach(location => {
            if (location.id === businessId) {
                businessDetail = location;
            }
        });
    });

    return businessDetail || null;
}
