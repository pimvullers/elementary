# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

VALA_MIN_API_VERSION=0.20

inherit gnome2-utils meson vala xdg-utils

DESCRIPTION="Pantheon Login Screen for LightDM"
HOMEPAGE="https://github.com/elementary/greeter"
SRC_URI="https://github.com/elementary/greeter/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="nls"

RDEPEND="
	>=dev-libs/granite-5.2.3
	sys-apps/accountsservice
	>=gnome-base/gnome-settings-daemon-3.27
	>=pantheon-base/wingpanel-2.0
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-wm/mutter
	gui-libs/libhandy:1
	>=x11-misc/lightdm-1.2.1[vala]"
DEPEND="${RDEPEND}
	$(vala_depend)
	dev-util/meson
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

S="${WORKDIR}/greeter-${PV}"

src_prepare() {
	eapply_user

	# Disable generation of the translations (if needed)
	use nls || sed -i '/add_subdirectory (po)/d' CMakeLists.txt

	vala_src_prepare
}

src_configure() {
	meson_src_configure
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
