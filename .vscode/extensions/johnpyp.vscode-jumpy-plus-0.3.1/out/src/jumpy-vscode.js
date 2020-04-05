"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode = require("vscode");
const plusMinusLines = 60;
const numCharCodes = 26;
function createCodeArray() {
    const codeArray = new Array(numCharCodes * numCharCodes);
    let codeIndex = 0;
    for (let i = 0; i < numCharCodes; i++) {
        for (let j = 0; j < numCharCodes; j++) {
            codeArray[codeIndex++] = String.fromCharCode(97 + i) + String.fromCharCode(97 + j);
        }
    }
    return codeArray;
}
exports.createCodeArray = createCodeArray;
let darkDataUriCache = {};
let lightDataUriCache = {};
function createDataUriCaches(codeArray, darkDecoration, lightDecoration) {
    codeArray.forEach(code => darkDataUriCache[code] = getSvgDataUri(code, darkDecoration));
    codeArray.forEach(code => lightDataUriCache[code] = getSvgDataUri(code, lightDecoration));
}
exports.createDataUriCaches = createDataUriCaches;
function getCodeIndex(code) {
    return (code.charCodeAt(0) - 97) * numCharCodes + code.charCodeAt(1) - 97;
}
exports.getCodeIndex = getCodeIndex;
function getLines(editor) {
    const document = editor.document;
    const activePosition = editor.selection.active;
    const startLine = activePosition.line < plusMinusLines ? 0 : activePosition.line - plusMinusLines;
    const endLine = (document.lineCount - activePosition.line) < plusMinusLines ? document.lineCount : activePosition.line + plusMinusLines;
    const lines = [];
    for (let i = startLine; i < endLine; i++) {
        lines.push(document.lineAt(i).text);
    }
    return {
        firstLineNumber: startLine,
        lines
    };
}
exports.getLines = getLines;
function createTextEditorDecorationType(dec) {
    const width = dec.fontSize + 6;
    const left = -width + 2;
    return vscode.window.createTextEditorDecorationType({
        after: {
            margin: `0 0 0 ${left}px`,
            height: '${dec.fontSize}px',
            width: `${width}px`
        }
    });
}
exports.createTextEditorDecorationType = createTextEditorDecorationType;
function createDecorationOptions(line, startCharacter, endCharacter, context, code) {
    return {
        range: new vscode.Range(line, startCharacter, line, endCharacter),
        renderOptions: {
            dark: {
                after: {
                    contentIconPath: darkDataUriCache[code]
                }
            },
            light: {
                after: {
                    contentIconPath: lightDataUriCache[code]
                }
            }
        }
    };
}
exports.createDecorationOptions = createDecorationOptions;
function getSvgDataUri(code, dec) {
    const width = dec.fontSize + 6;
    const svg = `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${width} ${dec.fontSize}" height="${dec.fontSize}" width="${width}"><rect width="${width}" height="${dec.fontSize}" rx="2" ry="2" style="fill: ${dec.bgColor};"></rect><text font-family="${dec.fontFamily}" font-size="${dec.fontSize}px" textLength="${width - 2}" textAdjust="spacing" fill="${dec.fgColor}" x="1" y="${dec.fontSize - 2}" alignment-baseline="baseline">${code}</text></svg>`;
    return vscode.Uri.parse(`data:image/svg+xml;utf8,${svg}`);
}
//# sourceMappingURL=jumpy-vscode.js.map