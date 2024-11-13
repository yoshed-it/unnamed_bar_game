from PIL import Image
import os


def get_directory():
    while True:
        directory = (input("In what directory are the images located?   \n(type 'exit' to quit): ")
                     .replace('\\', '/')
                     .strip('"'))

        if directory.lower() == 'exit':
            print("Exiting Program")
            return None

        print(f'Checking path: "{directory}"')
        abs_path = os.path.abspath(directory)
        print(f"Absolute path: {abs_path}")

        if os.path.exists(abs_path):
            print("Path exists!")
            basename = os.path.basename(os.path.normpath(directory))
            return directory, basename
        else:
            print(f"Path does NOT exist: {directory}\n")


def get_images(path):
    images = []
    for root, dirs, files in os.walk(path):
        for file in files:
            if not file.endswith('.import'):
                images.append(os.path.join(root, file))
    return images

def combine_images_x(path):
    image_paths = get_images(path)
    images = list(map(Image.open, image_paths))
    widths, heights = zip(*(image.size for image in images))

    total_width = sum(widths)
    total_height = max(heights)

    new_image = Image.new("RGBA", (total_width, total_height))

    x_offset = 0
    number_of_images = 0
    for image in images:
        new_image.paste(image, (x_offset, 0))
        x_offset += image.height
        number_of_images += 1

    return new_image, number_of_images



def main():
    directory, basename = get_directory()
    if directory:
        combined_images, number_of_images = combine_images_x(directory)
        save_path = os.path.join(directory, f"{basename}_combined_{number_of_images}.png")
        combined_images.save(save_path)


if __name__ == "__main__":
    main()

