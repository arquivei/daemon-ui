function fillStr(str, ...values) {
    let filledStr = str;
    values.forEach((val, index) => filledStr = filledStr.replace(`%{${index}}`, val));
    return filledStr;
}

function truncate(text, maxLength) {
    return text.length > maxLength ? `${text.substring(0, maxLength)}...` : text;
}
