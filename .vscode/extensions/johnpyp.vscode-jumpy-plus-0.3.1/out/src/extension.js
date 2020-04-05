'use strict';
Object.defineProperty(exports, "__esModule", { value: true });
const vscode = require("vscode");
const jumpy_vscode_1 = require("./jumpy-vscode");
const jumpy_positions_1 = require("./jumpy-positions");
function activate(context) {
    const codeArray = jumpy_vscode_1.createCodeArray();
    // decorations, based on configuration
    const editorConfig = vscode.workspace.getConfiguration('editor');
    const configuration = vscode.workspace.getConfiguration('jumpy');
    let fontFamily = configuration.get('fontFamily');
    fontFamily = fontFamily || editorConfig.get('fontFamily');
    let fontSize = configuration.get('fontSize');
    fontSize = fontSize || (editorConfig.get('fontSize') - 1);
    const colors = {
        darkBgColor: configuration.get('darkThemeBackground'),
        darkFgColor: configuration.get('darkThemeForeground'),
        lightBgColor: configuration.get('lightThemeBackground'),
        lightFgColor: configuration.get('lightThemeForeground')
    };
    const darkDecoration = {
        bgColor: colors.darkBgColor, fgColor: colors.darkFgColor,
        fontFamily: fontFamily, fontSize: fontSize
    };
    const lightDecoration = {
        bgColor: colors.lightBgColor, fgColor: colors.lightFgColor,
        fontFamily: fontFamily, fontSize: fontSize
    };
    jumpy_vscode_1.createDataUriCaches(codeArray, darkDecoration, lightDecoration);
    const decorationTypeOffset2 = jumpy_vscode_1.createTextEditorDecorationType(darkDecoration);
    const decorationTypeOffset1 = jumpy_vscode_1.createTextEditorDecorationType(darkDecoration);
    let positions = null;
    let firstLineNumber = 0;
    let isJumpyMode = false;
    setJumpyMode(false);
    let firstKeyOfCode = null;
    function setJumpyMode(value) {
        isJumpyMode = value;
        vscode.commands.executeCommand('setContext', 'jumpy.isJumpyMode', value);
    }
    function runJumpy(jumpyFn, regexp) {
        const editor = vscode.window.activeTextEditor;
        const getLinesResult = jumpy_vscode_1.getLines(editor);
        positions = jumpyFn(codeArray.length, getLinesResult.firstLineNumber, getLinesResult.lines, regexp);
        const decorationsOffset2 = positions
            .map((position, i) => position.charOffset == 1 ? null : jumpy_vscode_1.createDecorationOptions(position.line, position.character, position.character + 2, context, codeArray[i]))
            .filter(x => !!x);
        const decorationsOffset1 = positions
            .map((position, i) => position.charOffset == 2 ? null : jumpy_vscode_1.createDecorationOptions(position.line, position.character, position.character + 2, context, codeArray[i]))
            .filter(x => !!x);
        editor.setDecorations(decorationTypeOffset2, decorationsOffset2);
        editor.setDecorations(decorationTypeOffset1, decorationsOffset1);
        setJumpyMode(true);
        firstKeyOfCode = null;
    }
    function exitJumpyMode() {
        const editor = vscode.window.activeTextEditor;
        setJumpyMode(false);
        editor.setDecorations(decorationTypeOffset2, []);
        editor.setDecorations(decorationTypeOffset1, []);
    }
    const jumpyWordDisposable = vscode.commands.registerCommand('extension.jumpy-word', () => {
        const configuration = vscode.workspace.getConfiguration('jumpy');
        const defaultRegexp = '\\w{2,}';
        const wordRegexp = configuration ? configuration.get('wordRegexp', defaultRegexp) : defaultRegexp;
        runJumpy(jumpy_positions_1.jumpyWord, new RegExp(wordRegexp, 'g'));
    });
    context.subscriptions.push(jumpyWordDisposable);
    const jumpyLineDisposable = vscode.commands.registerCommand('extension.jumpy-line', () => {
        const configuration = vscode.workspace.getConfiguration('jumpy');
        const defaultRegexp = '^\\s*$';
        const lineRegexp = configuration ? configuration.get('lineRegexp', defaultRegexp) : defaultRegexp;
        runJumpy(jumpy_positions_1.jumpyLine, new RegExp(lineRegexp));
    });
    context.subscriptions.push(jumpyLineDisposable);
    const jumpyTypeDisposable = vscode.commands.registerCommand('type', args => {
        if (!isJumpyMode) {
            vscode.commands.executeCommand('default:type', args);
            return;
        }
        const editor = vscode.window.activeTextEditor;
        const text = args.text;
        if (text.search(/[a-z]/i) === -1) {
            exitJumpyMode();
            return;
        }
        if (!firstKeyOfCode) {
            firstKeyOfCode = text;
            return;
        }
        const code = firstKeyOfCode + text;
        const position = positions[jumpy_vscode_1.getCodeIndex(code.toLowerCase())];
        editor.setDecorations(decorationTypeOffset2, []);
        editor.setDecorations(decorationTypeOffset1, []);
        vscode.window.activeTextEditor.selection = new vscode.Selection(position.line, position.character, position.line, position.character);
        const reviewType = vscode.TextEditorRevealType.Default;
        vscode.window.activeTextEditor.revealRange(vscode.window.activeTextEditor.selection, reviewType);
        setJumpyMode(false);
    });
    context.subscriptions.push(jumpyTypeDisposable);
    const exitJumpyModeDisposable = vscode.commands.registerCommand('extension.jumpy-exit', () => {
        exitJumpyMode();
    });
    context.subscriptions.push(exitJumpyModeDisposable);
    const didChangeActiveTextEditorDisposable = vscode.window.onDidChangeActiveTextEditor(event => exitJumpyMode());
    context.subscriptions.push(didChangeActiveTextEditorDisposable);
}
exports.activate = activate;
function deactivate() {
}
exports.deactivate = deactivate;
//# sourceMappingURL=extension.js.map