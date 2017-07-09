# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

GNOME2_EAUTORECONF="yes"
inherit gnome2 systemd

DESCRIPTION="D-Bus interfaces for querying and manipulating user account information"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/AccountsService/"
SRC_URI="https://www.freedesktop.org/software/${PN}/${P}.tar.xz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"

IUSE="doc elogind +introspection selinux systemd +ubuntu"
SRC_URI="${SRC_URI}
	ubuntu? ( https://launchpad.net/ubuntu/+archive/primary/+files/accountsservice_0.6.42-0ubuntu1.debian.tar.xz )"

REQUIRED_USE="?? ( elogind systemd )"

CDEPEND="
	>=dev-libs/glib-2.37.3:2
	sys-auth/polkit
	elogind? ( >=sys-auth/elogind-229.4 )
	introspection? ( >=dev-libs/gobject-introspection-0.9.12:= )
	systemd? ( >=sys-apps/systemd-186:0= )
	!systemd? ( !elogind? ( sys-auth/consolekit ) )
	ubuntu? ( app-crypt/gcr )
"
DEPEND="${CDEPEND}
	dev-libs/libxslt
	dev-util/gdbus-codegen
	>=dev-util/gtk-doc-am-1.15
	>=dev-util/intltool-0.40
	sys-devel/gettext
	virtual/pkgconfig
	doc? (
		app-text/docbook-xml-dtd:4.1.2
		app-text/xmlto )
"
RDEPEND="${CDEPEND}
	selinux? ( sec-policy/selinux-accountsd )
"

PATCHES=(
	"${FILESDIR}/${PN}-0.6.35-gentoo-system-users.patch"
	"${FILESDIR}/${P}-elogind.patch"
)

src_prepare() {
	sed -i s/gdm3/gdm/ ${WORKDIR}/debian/patches/0007-add-lightdm-support.patch

	# Ubuntu patches
	if use ubuntu; then
		einfo "Applying patches from Ubuntu:"
		for patch in `cat "${FILESDIR}/${P}-ubuntu-patch-series"`; do
			eapply "${WORKDIR}/debian/patches/${patch}"
		done
	fi

	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		--disable-static \
		--disable-more-warnings \
		--localstatedir="${EPREFIX}"/var \
		--enable-admin-group="wheel" \
		--with-systemdsystemunitdir="$(systemd_get_systemunitdir)" \
		$(use_enable doc docbook-docs) \
		$(use_enable elogind) \
		$(use_enable introspection) \
		$(use_enable systemd)
}
