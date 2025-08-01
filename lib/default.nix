# Lib 模块入口 - 统一导入和导出所有工具函数
{ inputs }:

let
  utils = import ./utils.nix { inherit inputs; };
in
{
  # 重新导出所有工具函数
  inherit (utils)
    supportedSystems
    pkgsForSystem
    forEachSystem
    pkgsFor;

  # 向后兼容（可选，如果需要保持旧的名称）
  architectures = utils.supportedSystems;
}
