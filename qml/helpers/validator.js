function isEmailValid(email) {
    const pattern = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/;
    return pattern.test(email);
}

function isPasswordValid(password) {
    return password.length > 0;
}

// Comparação de pastas teve que ser dessa forma por causa dos prefixos do
// sistema de arquivos que variam de acordo com SO
function isSameFolder(selectedFolder, comparedFolder) {
    if (!selectedFolder || !comparedFolder) {
        return false;
    }

    const pattern = new RegExp(`^(file:\/{0,3})?${comparedFolder}$`);
    return pattern.test(selectedFolder);
}




