#ifndef URLREQUEST_HPP
#define URLREQUEST_HPP

#include <map>
#include <string>
#include <cstdint>
#include "URL.hpp"

namespace network {

#undef DELETE

    struct URLRequest {
        enum HTTPMethod {
            GET,
            POST,
            PUT,
            DELETE
        };

        URLRequest(URL url) : url(url), method(GET), timeoutInterval(10000) {}

        HTTPMethod method;

        URL url;

        std::string httpBody;

        std::map<std::string, std::string> httpHeaderFields;

        uint64_t timeoutInterval; // in ms
    };
}

#endif // URLREQUEST_HPP