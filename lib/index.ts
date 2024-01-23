import { getDefaultContext } from "@emnapi/runtime";
import createModule from "../dist/binding.js";

export default async function (moduleDefaults?: object) {
  const module = await createModule(moduleDefaults);
  return module.emnapiInit({ context: getDefaultContext() });
}
