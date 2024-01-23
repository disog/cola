interface InitOptions {
  context: import("@emnapi/runtime").Context;
  /** node_api_get_module_file_name */
  filename?: string;
  /**
   * Support following async_hooks related things
   * on Node.js runtime only
   *
   * napi_async_init,
   * napi_async_destroy,
   * napi_make_callback,
   * async resource parameter of
   * napi_create_async_work and napi_create_threadsafe_function
   */
  nodeBinding?: typeof import("@emnapi/node-binding");
  /** See Multithread part */
  asyncWorkPoolSize?: number;
}
interface Module {
  emnapiInit(options: InitOptions): typeof import("./cola.js");
}
export default function (moduleDefaults?: object): Promise<Module>;
