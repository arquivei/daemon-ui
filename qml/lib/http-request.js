function post(url, data = {}) {
    const { body = {}, headers = {}, query = {} } = data;
    const xhr = new XMLHttpRequest();
    const queryParams = Object.keys(query);
    let requestUrl = url;

    if (queryParams && queryParams.length) {
        requestUrl += '?';
        queryParams.forEach((paramName, index) => {
            requestUrl += `${paramName}=${query[paramName]}`;
            if (index < queryParams.length - 1) {
                requestUrl += '&';
            }
        })
    }

    xhr.open('POST', requestUrl, true);

    xhr.setRequestHeader('Content-Type', 'application/json;charset=UTF-8');

    Object.keys(headers).forEach((header) => xhr.setRequestHeader(header, headers[header]));

    xhr.send(JSON.stringify(body));

    return new Promise((resolve, reject) => {
       xhr.onreadystatechange = () => {
           if (xhr.readyState === XMLHttpRequest.DONE) {
               const response = {
                   statusCode: xhr.status
               };

               try {
                   response.data = JSON.parse(xhr.responseText);
               } catch (err) {
                   response.data = xhr.responseText;
               }

               if (response.statusCode >= 400) {
                   reject(response);
               } else {
                   resolve(response);
               }
           }
       }
    });
}
