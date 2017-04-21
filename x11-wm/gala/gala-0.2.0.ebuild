# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

VALA_MIN_API_VERSION=0.22
VALA_USE_DEPEND=vapigen

inherit gnome2-utils vala autotools

DESCRIPTION="Pantheon's Window Manager"
HOMEPAGE="https://launchpad.net/gala"
SRC_URI="https://launchpad.net/~elementary-os/+archive/ubuntu/stable/+files/gala_0.2.0%7Er481%2Bpkg32%7Eubuntu0.3.1.1.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	>=dev-libs/glib-2.32:2
	dev-libs/libgee:0.8
	media-libs/clutter-gtk
	<pantheon-base/plank-0.11
	>=x11-libs/granite-0.3
	x11-libs/bamf
	>=x11-libs/gtk+-3.4:3
	>=x11-wm/mutter-3.8.4
	gnome-base/gnome-desktop:3"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig"

src_unpack() {
	default_src_unpack

	mv "${WORKDIR}/gala-0.2.0~r481+pkg32~ubuntu0.3.1.1" "${S}"
}

src_prepare() {
	eapply_user

	eautoreconf

	vala_src_prepare
}

src_configure() {
	econf VALAC="${VALAC}" VAPIGEN="${VAPIGEN}"
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
