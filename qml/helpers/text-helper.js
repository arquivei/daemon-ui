function fillStr(str, ...values) {
    let filledStr = str;
    values.forEach((val, index) => filledStr = filledStr.replace(`%{${index}}`, val));
    return filledStr;
}
